# main terraform file

module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "${lower(var.stack__name)}-${lower(var.environment_name)}-web-server"
  instance_count         = var.instance_count

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name

  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]

  associate_public_ip_address = true
}