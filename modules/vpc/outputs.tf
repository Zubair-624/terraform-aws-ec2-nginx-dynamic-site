# vpc_id ---> used by security-group module || modules/security-group/main.tf 
output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.main.id
  
}

# public_subnet_id ---> used by ec2 module || modules/ec2/main.tf
output "public_subnet_id" {
    description = "ID of the public subnet"
    value = aws_subnet.main.id 
  
}

