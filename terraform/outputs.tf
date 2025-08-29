# output "ec2_public_ip" {
#   # value = aws_instance.terraform_ec2.public_ip # When single copy is being created
#   value = aws_instance.terraform_ec2[*].public_ip # When multiple copies are being created using 'count' 
# }

# output "ec2_public_dns" {
#   value = aws_instance.terraform_ec2[*].public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.terraform_ec2[*].private_ip
# }

output "ec2_public_ip" {
  value = {
    for idx, key in aws_instance.terraform_ec2 : idx => key.public_ip
  }
}

output "ec2_public_dns" {
  value = {
    for idx, key in aws_instance.terraform_ec2 : idx => key.public_dns
  }
}

output "ec2_private_ip" {
  value = {
    for idx, key in aws_instance.terraform_ec2 : idx => key.private_ip
  }
}