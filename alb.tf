//ALB
resource "aws_lb" "alb" {
  name               = "${lower(var.stack_name)}-${lower(var.environment_name)}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets
}

//Target Group
resource "aws_lb_target_group" "alb_tg" {
  name     = "${lower(var.stack_name)}-${lower(var.environment_name)}-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "target_registration" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.nginx_server[count.index].id
  port             = 80
}

//ALB Listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}