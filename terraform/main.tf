
terraform {
  backend "s3" {
    bucket   = "hogehoge-terraform-backend"
    key      = "tfstate.json"
    region   = "ap-northeast-1"
    role_arn = "arn:aws:iam::xxxxxxxxxxx:role/admin"
  }
}

locals {
  global_unique_prefix = "avilenhogehoge"
}

provider "aws" {
  region = "ap-northeast-1"
  assume_role {
    role_arn = "arn:aws:iam::xxxxxxxxxxx:role/admin"
  }
}

# NOTE: uncomment below if you want to use it.
# module "vpc" {
#   source = "git@github.com:avilendev/terraform-modules.git//standard_vpc"
# }

# module "instance" {
#   source        = "git@github.com:moajo/terraform-ec2-instance.git"
#   vpc_id        = module.vpc.vpc_id
#   subnet_id     = module.vpc.private_subnet_ids[0]
#   name          = "hogehoge"
#   # ami           = "ami-xxxxxxxxxxx"
#   instance_type = "g4dn.xlarge"
# }
