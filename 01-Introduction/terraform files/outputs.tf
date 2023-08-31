# Terraform Output Values
output "ansible_publicIp" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.ubuntu.public_ip
}

output "rhel_publicIp" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.rhel-hosts[*].public_ip
}

output "rhel_privateIp" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.rhel-hosts[*].private_ip
}

# EC2 Instance Public IP
output "instance_publicIp" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.ubuntu-hosts[*].public_ip
}

# EC2 Instance Public DNS
output "instance_privateIp" {
  description = "EC2 Instance Private IP"
  value       = aws_instance.ubuntu-hosts[*].private_ip
}
