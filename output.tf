# output the load balancer public dns address
output "load_balancer_dns" {
    value = aws_lb.alb.dns_name
}