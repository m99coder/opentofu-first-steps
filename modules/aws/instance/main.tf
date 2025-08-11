locals {
  full_instance_name = "${var.name_prefix}example-instance"
  full_sg_name       = "${var.name_prefix}example-security-group"
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.example.key_name
  user_data     = var.user_data

  tags = {
    name = local.full_instance_name
  }

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example.id]
}

resource "aws_security_group" "example" {
  name        = local.full_sg_name
  description = "Allow inbound HTTP traffic on port 22 and 80, and all outbound traffic"

  tags = {
    name = local.full_sg_name
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_key_pair" "example" {
  key_name   = "${var.name_prefix}example-key"
  public_key = file(var.ssh_key)

  tags = {
    name = "${var.name_prefix}example-key"
  }
}
