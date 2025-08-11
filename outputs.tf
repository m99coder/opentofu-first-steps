output "instance_arn" {
  description = "AWS EC2 Instance ARN"
  value       = aws_instance.example.arn
}

output "instance_url" {
  description = "AWS EC2 Instance IP Address"
  value       = "http://${aws_instance.example.public_ip}"
}
