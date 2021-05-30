### LOAD BALANCER SECURITY GROUP ###
# this security group allows the load balancer access to the internet and allows incoming HTTP and HTTPS access
resource "aws_security_group" "alb_sg" {
  name        = "${lower(var.stack_name)}-${lower(var.environment_name)}-alb-security-group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### EC2 SECURITY GROUP ###
# this security group gives the private ec2 instances access to the internet and also incoming HTTP access from the load balancer
resource "aws_security_group" "ec2_sg" {
  name        = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-security-group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}