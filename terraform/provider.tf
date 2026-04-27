terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"

    default_tags {
    tags = {
        Environment = "dev"
        CostCenter  = "learning"
        ManagedBy   = "terraform"
        Project = "terraform-aws-ec2-nginx-dynamic-site"
        Owner   = "zubair"
    }
}
  
}

