output "public_ip" {
    description = "Public IP of the EC2 instance"
    value = aws_instance.main.public_ip
  
}

output "public_dns" {
    description = "Public DNS of the EC2 instance"
    value = aws_instance.main.public_dns
  
}

output "instance_id" {
    description = "ID of the EC2 instance"
    value = aws_instance.main.id
  
}

output "ami_id" {
    description = "AMI ID used for the EC2 instance"
    value = data.aws_ami.ubuntu_24_04.id
  
}