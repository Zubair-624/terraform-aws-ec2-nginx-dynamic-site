# This vpc_id is point to the modules/vpc/variables.tf 
variable "vpc_id" {
    description = "ID of the VPC — comes from vpc module output"
    type = string
  
}

variable "ssh_cidr" {
    description = "My IP range allowed for SSH access"
    type = string
    default = "180.94.28.0/24"

  
}

variable "project_name" {
    description = "Project name used for naming all resources"
    type = string
  
}

