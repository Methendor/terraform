output "load_balancer_dns" {
    value = aws_lb.alb.dns_name
}

output "ec2_ips" {
    value = aws_instance.nginx_server.*.public_ip
}