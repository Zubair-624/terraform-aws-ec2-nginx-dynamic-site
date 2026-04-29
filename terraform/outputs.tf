output "ec2_public_ip" {
    description = "Public IP of the EC2 instance"
    value       = module.ec2.public_ip
}

output "ec2_public_dns" {
    description = "Public DNS of the EC2 instance"
    value       = module.ec2.public_dns
}

output "ec2_instance_id" {
    description = "ID of the EC2 instance"
    value       = module.ec2.instance_id
}

output "vpc_id" {
    description = "ID of the VPC"
    value       = module.vpc.vpc_id
}

output "website_url" {
    description = "URL to access your website"
    value       = "http://${module.ec2.public_ip}"
}