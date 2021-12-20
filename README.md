## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_ingress"></a> [default\_ingress](#input\_default\_ingress) | Default values of ingress if not set, port value override from\_port and to\_port | <pre>object(<br>    {<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = list(string)<br>      ipv6_cidr_blocks = list(string)<br>      description      = string<br>      prefix_list_ids  = list(string)<br>      self             = bool<br>      security_groups  = list(string)<br>    }<br>  )</pre> | <pre>{<br>  "cidr_blocks": [],<br>  "description": "",<br>  "from_port": -1,<br>  "ipv6_cidr_blocks": [],<br>  "prefix_list_ids": [],<br>  "protocol": "tcp",<br>  "security_groups": [],<br>  "self": false,<br>  "to_port": -1<br>}</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the security group | `string` | n/a | yes |
| <a name="input_egress"></a> [egress](#input\_egress) | Egress rules of the security group | <pre>list(<br>    object({<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = list(string)<br>      ipv6_cidr_blocks = list(string)<br>      description      = string<br>      prefix_list_ids  = list(string)<br>      self             = bool<br>      security_groups  = list(string)<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "egress",<br>    "from_port": 0,<br>    "ipv6_cidr_blocks": [],<br>    "prefix_list_ids": null,<br>    "protocol": "-1",<br>    "security_groups": [],<br>    "self": false,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Ingress rules of the security group | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of the security group | `map(any)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id of the security group | `string` | `null` | no |

## Outputs

No outputs.
