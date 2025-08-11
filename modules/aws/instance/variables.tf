variable "name_prefix" {
  type = string
}

variable "ami" {
  type    = string
  default = "ami-0558b9a4391973c28"
}

variable "instance_type" {
  type    = string
  default = "t4g.micro"
}

variable "user_data" {
  type    = string
  default = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y docker
  sudo service docker start
  sudo usermod -a -G docker ec2-user
  sudo docker run -d -p 80:80 nginx:latest
  EOF
}

variable "ssh_key" {
  type = string
}
