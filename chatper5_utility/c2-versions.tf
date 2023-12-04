# command to determine which availability zone use the instance type you're going to be using
# aws ec2 describe-instance-type-offerings --location-type availability-zone --filters Name=instance-type,Values=t2.micro --region us-east-1 --output table

# # Datasource
# data "aws_ec2_instance_type_offerings" "my_ins_type1" {
#     filter {
#         name = "instance-type"
#         values = ["t3.micro"]
#     }
    
#     filter {
#         name = "location"
#         # values = ["us-east-1a"]
#         values = ["us-east-1e"]
#     }

#     location_type = "availability-zone"

# }

# #Output

# output "output_v1_1" {
#     value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
# }


# # Part 2

# # Datasource
# data "aws_ec2_instance_type_offerings" "my_ins_type2" {
#     for_each = toset(["us-east-1a", "us-east-1b", "us-east-1e"])

#     filter {
#         name = "instance-type"
#         values = ["t3.micro"]
#     }
    
#     filter {
#         name = "location"
#         # values = ["us-east-1a"]
#         values = [each.key]
#     }

#     location_type = "availability-zone"

# }

# #Output NOTE: Once for_each is set, its attributes much be accesed on specific instances

# output "output_v2_1" {
#     # value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
#     value = [for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types]

# }

# output "output_v2_2" {
#     value = {
#         for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
#     }
# }

# Part 3

data "aws_availability_zones" "my_azones" {
    filter {
        name = "opt-in-status"
        values = ["opt-in-not-required"]
    }
}

data "aws_ec2_instance_type_offerings" "my_ins_type3" {
    for_each = toset(data.aws_availability_zones.my_azones.names)

    filter {
        name = "instance-type"
        values = ["t3.micro"]
    }
    
    filter {
        name = "location"
        # values = ["us-east-1a"]
        values = [each.key]
    }

    location_type = "availability-zone"
}

output "output_v3_1" {
    value = {for az, details in data.aws_ec2_instance_type_offerings.my_ins_type3: az => details.instance_types}
}

output "output_v3_2" {
    value = {for az, details in data.aws_ec2_instance_type_offerings.my_ins_type3: 
    az => details.instance_types if length(details.instance_types) != 0
    }
}

output "output_v3_3" {
    value = keys({for az, details in data.aws_ec2_instance_type_offerings.my_ins_type3: 
    az => details.instance_types if length(details.instance_types) != 0
    })
}

# output_v3_3 = [
    #   + "us-east-1a",
    #   + "us-east-1b",
    #   + "us-east-1c",
    #   + "us-east-1d",
    #   + "us-east-1f",
    # ]

output "output_v3_4" {
    value = keys({for az, details in data.aws_ec2_instance_type_offerings.my_ins_type3: 
    az => details.instance_types if length(details.instance_types) != 0
    })[0]
}