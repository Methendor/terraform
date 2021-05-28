//EC2 Instances
resource "aws_instance" "compute_nodes" {
  ami                       = var.ami
  instance_type             = var.instance_type
  count                     = length(data.aws_availability_zones.available.names)
  security_groups           = [aws_security_group.alb_sg.id]
  subnet_id                 = element(module.vpc.public_subnets, count.index)
  key_name                  = var.key_name

  user_data = <<-EOT
    echo "<h1>${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-${count.index}</h1>" | sudo tee /opt/bitnami/nginx/html/index.html
  EOT
  
  tags = {
    Name = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-${count.index}"
  }
}

