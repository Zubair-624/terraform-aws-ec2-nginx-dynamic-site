# ----------Latest Ubuntu 24.04 AMI----------
data "aws_ami" "ubuntu_24_04" {

    most_recent = true
    owners = ["099720109477"]

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  
}

#----------EC2 Instance----------
resource "aws_instance" "main" {

    tags = {
        name = "${var.project_name}-ec2"
    }

    ami = data.aws_ami.ubuntu_24_04

    instance_type = var.instance_type

    key_name = var.key_name

    # VPC + Subnet (subnet_id)
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true 
    vpc_security_group_ids = [var.security_group_id]

    root_block_device {

      volume_size = var.volume_size
      volume_type = "gp3"
      delete_on_termination = true 

      tags = {
            Name = "${var.project_name}-root-volume"
        }
    }

    user_data = file(var.user_data_path)

  
}