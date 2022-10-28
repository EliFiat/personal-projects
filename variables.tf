
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
 }

variable "private_cidr" { 
    type = list 
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_cidr" { 
    type = list 
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# Below is the EC2 variables blocks
variable "ec2_name_tag" {
  default = ["web1", "web2","web3"]
}

variable "instance_type" {
    type = string
  default = "t2.micro"
}

variable "ami_ids" {
  default = "ami-09d3b3274b6c5d4aa"
}

variable "azs" { 
    default = {
        0 = "us-east-1a"
        1 = "us-east-1b"
        2 = "us-east-1c"
    }
}

# variable "vpc_id" {
#     default = module.vpc.vpc_id
#  }

