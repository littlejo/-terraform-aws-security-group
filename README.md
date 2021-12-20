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
| <a name="input_description"></a> [description](#input\_description) | (Required) Description of the security group | `string` | n/a | yes |
| <a name="input_egress"></a> [egress](#input\_egress) | (Optional) Egress rules of the security group | <pre>list(<br>    object({<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = list(string)<br>      ipv6_cidr_blocks = list(string)<br>      description      = string<br>      prefix_list_ids  = list(string)<br>      self             = bool<br>      security_groups  = list(string)<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "egress",<br>    "from_port": 0,<br>    "ipv6_cidr_blocks": [],<br>    "prefix_list_ids": null,<br>    "protocol": "-1",<br>    "security_groups": [],<br>    "self": false,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | (Optional) Ingress rules of the security group. Default ingress is described on ingress\_default variable<br><br>(Optional) description - description of the rule - string<br>(Optional) protocol - protocol to use ("tcp", "udp", "icmp", "-1" for all). If "-1", you need to use "port = 0" - string<br>(Optional) port - port number to open - number<br>(Optional) from\_port - begin of port range (do not use from\_port and port at the same time) - number<br>(Optional) to\_port - end of port range (do not use to\_port and port at the same time) - number<br>(Optional) cidr\_blocks - cidr list - list(string)<br>(Optional) ipv6\_cidr\_blocks - cidr list in IPv6 - list(string)<br>(Optional) prefix\_list\_ids - list of ids of prefix list - list(string)<br>(Optional) security\_groups - list(string)<br>(Optional) self - if this security group is include in this rule - bool | `list(any)` | `[]` | no |
| <a name="input_ingress_default"></a> [ingress\_default](#input\_ingress\_default) | (Optional) Default values of ingress if not set, port value override from\_port and to\_port | <pre>object(<br>    {<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = list(string)<br>      ipv6_cidr_blocks = list(string)<br>      description      = string<br>      prefix_list_ids  = list(string)<br>      self             = bool<br>      security_groups  = list(string)<br>    }<br>  )</pre> | <pre>{<br>  "cidr_blocks": [],<br>  "description": "",<br>  "from_port": 0,<br>  "ipv6_cidr_blocks": [],<br>  "prefix_list_ids": [],<br>  "protocol": "tcp",<br>  "security_groups": [],<br>  "self": false,<br>  "to_port": 65535<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of the security group | `map(any)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional) VPC id of the security group (by default, default vpc id) | `string` | `null` | no |

## Outputs

No outputs.
