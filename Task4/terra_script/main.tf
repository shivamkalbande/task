provider "aws" {
	access_key ="&&&&&&&&&&&"
	secret_key ="********************"
	region     = "ap-south-1"
}

##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block 	       = "10.11.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
    Project = "DevOps_Task"
  } 
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.2.0/24"
  map_public_ip_on_launch = false 
  tags = {
    Name = "Private Subnet"
    Project = "DevOps_Task"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
    Project = "DevOps_Task"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Internet Gateway"
    Project = "DevOps_Task"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Demo VPC Public Route Table"
    Project = "DevOps_Task"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "EC2_web_server" {
  ami                    = "ami-03f4878755434977f"       # Specify your AMI ID
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = "terraform_key" # Specify your key pair name
  vpc_security_group_ids = [
	aws_security_group.ssh_access.id
]
  user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        echo "<html><body><h1>Welcome to my website! Hello from your EC2 instance!</h1></body></html>" > /var/www/html/index.html
        sudo systemctl restart apache2
  EOF

  tags = {
    Name = "User-Data-Script-for-EC2"
    Project = "DevOps_Task"
  }
}

resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh_access"
  vpc_id      =  aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
    Name = "demo-ssh-security-group"
    Project = "DevOps_Task"
  }
}

#resource "aws_eip" "eip" {
#  instance = aws_instance.web_server.id
  
#  tags = {
#    Name = "My-Ec2-test-eip"
#  }
#}

resource "aws_eip" "example" {
  instance = aws_instance.EC2_web_server.id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.EC2_web_server.id
  allocation_id = aws_eip.example.id
}






