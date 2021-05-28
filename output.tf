output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = module.ec2.public_ip
}