# Input Variables

# AWS Region
variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "us-east-1"
}

variable "instance_type" {
    description = "EC2 Instance Type"
    type = string
    default = "t2.micro"
    # sensitive = true
    # validation {
    #     need to figure out what this part means?
    # }
}

variable "instance_keypair" {
    description = "AWS EC2 KeyPair that needs to be associated with the EC2 Instance"
    type = string
    default = "aws_terraform"
}