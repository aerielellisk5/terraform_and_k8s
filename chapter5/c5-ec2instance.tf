data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

#data.aws_availability_zones.my_azones.names #this will provide list values; needs to convert to a set by using the toset functions.  Will convert everything to the same type.  Will lose duplicate values and will be an unordered set

resource "aws_instance" "myec2vm" {
  ami           = data.aws_ami.amzlinux2023.id
  instance_type = var.instance_type_list[1] #for list
  # instance_type = var.instance_type_map["prod"]
  user_data = file("${path.module}/app1-install.sh")
  key_name  = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id
  ]
  # count = 2 ; Apparently you can either use count OR for each, not both!
  for_each          = toset(data.aws_availability_zones.my_azones.names) #["us-east-1a", "us-east-1b"]
  availability_zone = "each.key"
  tags = {
    # "Name" = "Count Demo ${count.index}"
    "Name" = "For-Each-Demo-${each.value}"
  }
}