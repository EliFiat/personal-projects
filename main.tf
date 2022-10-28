
### terraform block ( used to set constraint)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider (authentication and authorization)
provider "aws" {
  region = "us-east-1"
}


### VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bank_vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_cidr
  public_subnets  = var.public_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

### data source
data "aws_availability_zones" "available" {
  state = "available"
}


### EC2 Instance ## https://stackoverflow.com/questions/71359239/terraform-how-to-output-multiple-value
## in order to dynami
resource "aws_instance" "web" {
  ami           = var.ami_ids
  # availability_zone = slice(data.aws_availability_zones.available.names, 0,3)
  availability_zone = var.azs[count.index]
  instance_type = var.instance_type
  count = length(var.ec2_name_tag)
  # subnet_id = var.subnet_ids[count.index]
  subnet_id = module.vpc.private_subnets[count.index]

  tags = {
    Name = var.ec2_name_tag[count.index]
  }
}

### EC2 LB target group
resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

# ### TARGET GROUP ATTACHMENT
# resource "aws_lb_target_group_attachment" "web-tg-attach" {
#   target_group_arn = aws_lb_target_group.web_target_group.arn
#   target_id        = aws_instance.web.id[*]
#   port             = 80
# }



# data "aws_subnets" "private" {
#   vpc_id = module.vpc.vpc_id

# }