locals {
  ingress = [
    for ingress in var.ingress :
    {
      from_port        = try(ingress.from_port, try(ingress.port, var.default_ingress.from_port))
      to_port          = try(ingress.to_port, try(ingress.port, var.default_ingress.to_port))
      protocol         = try(ingress.protocol, var.default_ingress.protocol)
      cidr_blocks      = try(ingress.cidr_blocks, var.default_ingress.cidr_blocks)
      ipv6_cidr_blocks = try(ingress.ipv6_cidr_blocks, var.default_ingress.ipv6_cidr_blocks)
      description      = try(ingress.description, var.default_ingress.description)
      prefix_list_ids  = try(ingress.prefix_list_ids, var.default_ingress.prefix_list_ids)
      self             = try(ingress.self, var.default_ingress.self)
      security_groups  = try(ingress.security_groups, var.default_ingress.security_groups)
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
