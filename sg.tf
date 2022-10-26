
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id  # we call the value of the output vpc  id from the vpc module

  ingress_cidr_blocks = ["10.10.0.0/16"]
}