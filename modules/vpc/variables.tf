variable "aws_vpc_cidr" {
    description = "CIDR block for the AWS VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.1.0/24"
  
}

variable "az" {
    description = "AZ for the public subnet"
    type = string
    default = "us-east-1a"
  
}

variable "project_name" {
    description = "Project name used for naming all resources"
    type = string
  
}


