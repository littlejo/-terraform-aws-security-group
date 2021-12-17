module "ssh" {
  source = "../.."
  name = "ssh"
  description = "access to ssh"
  ingress = [
    {
      description     = "ssh"
      port            = 22
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]
}
