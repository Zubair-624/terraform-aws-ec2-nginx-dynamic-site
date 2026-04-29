variable "project_name" {
    description = "Project name used for naming all resources"
    type = string
  
}

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

variable "public_subnet_id" {
    description = "ID of the public subnet — comes from vpc module output"
    type = string

}

variable "security_group_id" {
    description = "ID of the security group — comes from security-group module output"
  
}

variable "volume_size" {
    description = "Root volume size in GB"
    type = number
    default = 8
  
}

variable "user_data_path" {
    description = "Path to the user data shell script"
    type = string
  
}

variable "iam_instance_profile" {
    description = "IAM instance profile name to attach to EC2"
    type = string
  
}