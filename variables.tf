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
  description = "Ingress rules of the security group"
  type        = list(any)
  default     = []
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
    from_port        = -1
    to_port          = -1
    protocol         = "tcp"
    description      = ""
    self             = false
    prefix_list_ids  = []
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
  }
}

variable "tags" {
  description = "Tags of the security group"
  type        = map(any)
  default     = {}
}
