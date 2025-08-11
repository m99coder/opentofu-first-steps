output "instance_arn" {
  description = "AWS EC2 Instance ARN"
  value       = module.aws_instance.instance_arn
}

output "instance_url" {
  description = "AWS EC2 Instance URL"
  value       = "http://${module.aws_instance.instance_ip}"
}

output "instance_ssh" {
  description = "SSH Command to Connect to AWS EC2 Instance"
  value       = "ssh -i ${var.ssh_key} ec2-user@${module.aws_instance.instance_ip}"
}
