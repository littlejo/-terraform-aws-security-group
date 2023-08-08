module "test" {
  source      = "../.."
  name        = "test"
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
