
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