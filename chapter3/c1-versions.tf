#  Terraform block
terraform {
  required_version = "~> 1.5.2" # allows 1.5.1, deny 1.6.2
  required_providers {
    aws = {
        source = "value"
        version = "value"
    }
  }
}

# Provider block
# provider should match the provider block
provider "aws" {
  region = "us-east-1"
}