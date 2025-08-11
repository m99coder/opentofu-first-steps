locals {
  name_prefix = coalesce(var.name_prefix, "") != "" ? "${var.name_prefix}-" : ""
}

module "aws_instance" {
  source = "./modules/aws/instance"

  name_prefix = local.name_prefix
  ssh_key     = var.ssh_key
}
