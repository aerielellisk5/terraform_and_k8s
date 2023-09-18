#  Terraform block
terraform {
  required_version = "~> 1.5.2" # allows 1.5.1, deny 1.6.2
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.65"
    }
  }
}

# Provider block
# provider should match the provider block
provider "aws" {
  region = "us-east-1"
}

# resource "aws_vpc" "vpc_us-west-1" {
#     #  resource resource_type resource_local_name
#   provider = aws.aws-west-1
#   # provider, for_each, count --> are called meta-arguements; will change the behavior of the resource
#   cidr_block = "10.2.0.0/16"
#   tags = {
#     "name" = "vpc-1"
#   }
# }