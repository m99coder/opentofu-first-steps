variable "name_prefix" {
  type = string
}

variable "ami" {
  type    = string
  default = "ami-026af385507ebaadc"
}

variable "instance_type" {
  type    = string
  default = "t4g.micro"
}

variable "user_data" {
  type    = string
  default = <<-EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras install docker -y
  service docker start
  usermod -a -G docker ec2-user
  docker run -d -p 80:80 nginx:latest
  EOF
}

variable "ssh_key" {
  type = string
}
