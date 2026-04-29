#----------VPC Module----------
module "vpc" {
    
    source = "../modules/vpc"

    project_name = var.project_name

    aws_vpc_cidr = var.aws_vpc_cidr

    public_subnet_cidr = var.public_subnet_cidr

    az = var.az
  
}

#----------Security Group Module----------
module "security_group" {

    source = "../modules/security-group"

    project_name = var.project_name

    vpc_id = module.vpc.vpc_id

    ssh_cidr = var.ssh_cidr
  
}

#----------IAM Role - allows EC2 to read from S3----------

resource "aws_iam_role" "ec2_s3_role" {
    name = "${var.project_name}-ec2-s3-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })

    tags = {
        Name = "${var.project_name}-ec2-s3-role"
    }
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
    name = "${var.project_name}-ec2-s3-policy"
    role = aws_iam_role.ec2_s3_role.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "s3:GetObject",
                    "s3:ListBucket"
                ]
                Resource = [
                    "arn:aws:s3:::devops-zubair-terraform-state",
                    "arn:aws:s3:::devops-zubair-terraform-state/*"
                ]
            }
        ]
    })
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name = "${var.project_name}-ec2-profile"
    role = aws_iam_role.ec2_s3_role.name
}

#----------EC2 Module----------
module "ec2" {
    source = "../modules/ec2"

    project_name         = var.project_name

    instance_type        = var.instance_type

    key_name             = var.key_name

    public_subnet_id     = module.vpc.public_subnet_id
    security_group_id    = module.security_group.security_group_id

    volume_size          = var.volume_size

    user_data_path       = "${path.module}/../scripts/user_data.sh"
    
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}