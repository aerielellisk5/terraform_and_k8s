resource "aws_instance" "myec2vm" {
  ami           = "ami-04cb4ca688797756f"
  instance_type = "t2.micro"
#   user_data     = file("${path.module}/app1-install.sh")
  user_data     = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}