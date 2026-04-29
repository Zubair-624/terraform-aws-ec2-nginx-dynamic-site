variable "project_name" {
    description = "Project name used for naming all resources"
    type = string
  
}

#----------VPC----------
variable "aws_vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.1.0/24"
  
}

variable "az" {
    description = "Availability zone for the public subnet"
    type = string
    default = "us-east-1a"
  
}

#----------Security Group----------
variable "ssh_cidr" {
    description = "Your IP range allowed for SSH access"
    type = string
    default = "180.94.28.0/24"
  
}

#----------EC2----------
variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    description = "AWS Key Pair name for SSH access"
    type = string
    default = "devops-zubair-terminal-key"
  
}

variable "volume_size" {
    description = "Root volume size in GB"
    type = number
    default = 8
  
}