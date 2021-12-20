locals {
  ingress = [
    for ingress in var.ingress :
    {
      from_port        = try(ingress.from_port, try(ingress.port, var.ingress_default.from_port))
      to_port          = try(ingress.to_port, try(ingress.port, var.ingress_default.to_port))
      protocol         = try(ingress.protocol, var.ingress_default.protocol)
      cidr_blocks      = try(ingress.cidr_blocks, var.ingress_default.cidr_blocks)
      ipv6_cidr_blocks = try(ingress.ipv6_cidr_blocks, var.ingress_default.ipv6_cidr_blocks)
      description      = try(ingress.description, var.ingress_default.description)
      prefix_list_ids  = try(ingress.prefix_list_ids, var.ingress_default.prefix_list_ids)
      self             = try(ingress.self, var.ingress_default.self)
      security_groups  = try(ingress.security_groups, var.ingress_default.security_groups)
    }
  ]
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress = local.ingress
  egress  = var.egress

  tags = var.tags
}
