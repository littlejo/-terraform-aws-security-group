locals {
  ingress_tmp = [
    for ingress in var.ingress :
    strcontains(ingress.protocol, ",") ?
    [
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = split(",", ingress.protocol)[0]
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      },
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = split(",", ingress.protocol)[1]
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      }
    ]
    :
    [
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = ingress.protocol
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      }
    ]
  ]

  ingress = flatten(local.ingress_tmp)
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress = local.ingress
  egress  = var.egress

  tags = merge({ Name = var.name }, var.tags)
}
