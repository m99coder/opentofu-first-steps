resource "aws_instance" "example" {
  ami           = "ami-026af385507ebaadc"
  instance_type = "t4g.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example.id]

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras install docker -y
  service docker start
  usermod -a -G docker ec2-user
  docker run -d -p 80:80 ${var.image.name}:${var.image.tag}
  EOF

  tags = {
    name = "${var.name_prefix}-example-instance"
  }
}

resource "aws_security_group" "example" {
  name        = "${var.name_prefix}-example-security-group"
  description = "Allow inbound HTTP traffic on port 80 and all outbound traffic"

  ingress {
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
