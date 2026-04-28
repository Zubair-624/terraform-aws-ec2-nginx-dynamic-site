output "security_group_id" {
    description = "ID of the security group — used by ec2 module"
    value = aws_security_group.main.id
    
  
}