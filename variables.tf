variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC id of the security group"
  type        = string
  default     = null
}

variable "ingress" {
  description = <<EOF
Ingress rules of the security group. Default ingress is described on default_ingress variable

(Optional) description - description of the rule - string
(Optional) protocol - protocol to use ("tcp", "udp", "icmp", "-1" for all). If "-1", you need to use "port = 0" - string
(Optional) port - port number to open - number
(Optional) from_port - begin of port range (do not use from_port and port at the same time) - number
(Optional) to_port - end of port range (do not use to_port and port at the same time) - number
(Optional) cidr_blocks - cidr list - list(string)
(Optional) ipv6_cidr_blocks - cidr list in IPv6 - list(string)
(Optional) prefix_list_ids - list of ids of prefix list - list(string)
(Optional) security_groups - list(string)
(Optional) self - if this security group is include in this rule - bool
EOF
  type        = list(any)
  default     = []
}

variable "default_ingress" {
  description = "Default values of ingress if not set, port value override from_port and to_port"
  type = object(
    {
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
      description      = string
      prefix_list_ids  = list(string)
      self             = bool
      security_groups  = list(string)
    }
  )
  default = {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    description      = ""
    self             = false
    prefix_list_ids  = []
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
  }
}


variable "egress" {
  description = "Egress rules of the security group"
  type = list(
    object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
      description      = string
      prefix_list_ids  = list(string)
      self             = bool
      security_groups  = list(string)
    })
  )
  default = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    description      = "egress"
    prefix_list_ids  = null
    self             = false
    security_groups  = []
  }]
}

variable "tags" {
  description = "Tags of the security group"
  type        = map(any)
  default     = {}
}
