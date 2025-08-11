variable "name_prefix" {
  type = string
}

variable "image" {
  type = object({
    name = string
    tag  = string
  })

  default = {
    name = "nginx"
    tag  = "latest"
  }
}
