//EC2 Instances
resource "aws_instance" "compute_nodes" {
  ami                       = var.ami
  instance_type             = var.instance_type
  count                     = var.instance_count
  security_groups           = [aws_security_group.alb_sg.id]
  subnet_id                 = element(module.vpc.public_subnets, count.index)
  key_name                  = var.key_name

  user_data = templatefile("update_index.sh", { server_name = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-${count.index}" })
  
  tags = {
    Name = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-${count.index}"
  }
}

