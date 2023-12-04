# Output - For Loop with List

output "for_output_list" {
  description = "For Loop with List"
  value       = [for instance in aws_instance.myec2vm : instance.public_dns]
}

#Output - For Look with Map
output "for_output_map" {
  description = "For Loop with Map"
  value       = { for instance in aws_instance.myec2vm : instance.id => instance.public_dns }
}

# Output - For Loop with Map Advanced
output "for_output_map1" {
  description = "For Loop with Map1"
  value       = { for c, instance in aws_instance.myec2vm : c => instance.public_dns }
}



# THIS WORKS WITH COUNT! Output Legacy Splat Operator (Legacy) - returns the list; will eventually not work 
# output "legacy_splat_insatnce_publicdns" {
#   description = "Legacy Splat Expression or Operator"
#   value       = aws_instance.myec2vm.*.public_dns
# }


# THIS WORKS WITH COUNT!  Output Latest Generalized Splat Operator - Returns the list
# output "latest_splat_insatnce_publicdns" {
#   description = "Latest Splat Expression or Operator"
#   value       = aws_instance.myec2vm[*].public_dns
# }

#EC2 Instance Public IP with TOSET
output "instance_publicip_with_toset" {
  value = toset([for instance in aws_instance.myec2vm : instance.public_ip])
}

#EC2 Instance DNS with TOSET
output "instance_public_dns_with_toset" {
  value = toset([for instance in aws_instance.myec2vm : instance.public_dns])
}

#EC2 Instance Public DNS with TOMAP
output "instance_publicdns2_with_tomap" {
    value = {for az, instance in aws_instance.myec2vm : az => instance.public_dns} #you can also use the "tomap" function to convert them to the same type
}