##################
### Networking ###
#################
output "vpc_id" {
  value       = var.vpc
  description = "VPC id"
}

output "subnet_id" {
  value       = aws_launch_template.this.network_interfaces[*].subnet_id
  description = "Subnets"
}

############
### SG   ###
############
output "bastion_host_security_group" {
  value       = aws_security_group.bastion-sg.id
  description = "Bastion host security group id"
}