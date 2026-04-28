resource "aws_vpc" "main" {
    
    tags = {
        Name = "devops-web-nginx-vpc"
    }

    cidr_block = "10.0.0.0/16"
  
}

resource "aws_internet_gateway" "main" {

    tags = {
        Name = "devops-web-nginx-igw"
    }

    vpc_id = aws_vpc.main.id
  
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "devops-web-nginx-public-subnet-1"
    } 

    availability_zone = var.az

    cidr_block = "10.0.1.0/24"

    map_public_ip_on_launch = true

}

resource "aws_route_table" "main" {
    tags = {
        Name = "devops-web-nginx-rt"
    }

    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

}

resource "aws_route_table_association" "rt_assoc_with_public_subnet" {
    route_table_id = aws_route_table.main.id 

    subnet_id = aws_subnet.main.id
  
}

resource "aws_security_group" "sg" {
    tags = {
        Name = "devops-web-nginx-sg"
    }
    description = "Allow SSH and HTTP access for EC2 Nginx server"

    vpc_id = aws_vpc.main.id

    # Inbound Rules(HTTP, SSH)
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["180.94.28.0/24"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #Outbound Rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


#--------------------EC2--------------------
data "aws_ami" "ubuntu_24_04" {
    most_recent = true 
    owners = ["099720109477"]

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

resource "aws_instance" "main" {

    tags = {
        Name = "devops-web-nginx-ec2"
    }

    ami = data.aws_ami.ubuntu_24_04.id

    instance_type = "t2.micro"

    key_name = "devops-terminal-key"

    subnet_id = aws_subnet.main.id 

    associate_public_ip_address = true

    vpc_security_group_ids = [aws_security_group.sg.id]

     root_block_device {
       volume_size = 8
       volume_type = "gp3"
       delete_on_termination = true 
    }

    user_data = file("${path.module}/../scripts/user_data.sh")

}
