#----------VPC----------
resource "aws_vpc" "main" {
    
    tags = {
        Name = "${var.project_name}-vpc"
    }

    cidr_block = var.aws_vpc_cidr

    enable_dns_support = true 
    enable_dns_hostnames = true 
  
}

#----------IGW----------
resource "aws_internet_gateway" "main" {

    tags = {
        Name = "${var.project_name}-igw"
    }

    vpc_id = aws_vpc.main.id
  
}

#----------Subnet (Public Subnet)----------
resource "aws_subnet" "main" {

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-public-subnet-1"
    } 

    availability_zone = var.az

    cidr_block = var.public_subnet_cidr

    map_public_ip_on_launch = true

}

#----------Route Table (Public Route Table----------
resource "aws_route_table" "public" {
    tags = {
        Name = "${var.project_name}-public-rt"
    }

    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

}

#----------Route Table Association with Subent(Public Subnet)
resource "aws_route_table_association" "public" {

    route_table_id = aws_route_table.public.id 

    subnet_id = aws_subnet.public.id
  
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

    key_name = "devops-zubair-terminal-key"

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
