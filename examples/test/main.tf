terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "name" {
  default = "test"
}

module "test" {
  source      = "../.."
  name        = var.name
  description = "test"
  ingress = [
    {
      description = "ssh"
      port        = 22
      cidr_blocks = ["0.0.0.0/0", "10.0.0.0/8"]
      protocol    = "tcp"
    },
    {
      description = "dns"
      port        = 53
      cidr_blocks = ["0.0.0.0/0", "10.0.0.0/8"]
      protocol    = "tcp,udp"
    },
  ]
}

output "test" {
  value = module.test.security_group_id
}
