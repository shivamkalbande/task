
##Task 4: Terraform, AWS, Sample App
Important Note: Do not push your AWS Access key and Secret key to GitHub 
repository

##Task Overview

1.  Install Terraform on your local laptop
2.  Create Access keys in your AWS account
3.  Install AWS CLI on your local laptop
4.  Configure AWS on your local laptop using Access key and Secret key
5.  Create Terraform script to create infrastructure on AWS
  
 ---

##1.  **Installing Terraform**
  - Download the latest version of Terraform from the official website (https://www.terraform.io/downloads.html)
    
- Go to below link and download the .exe file on windows machine. 
OR 
>https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_windows_386.zip

- Unzip the file in  C:\terraform folder (or any other location you prefer) 

- Open command prompt  and navigate to that directory using cd command. 

- Check the version of terraform using below command: 

`terraform --version`

![alt text](terraversion.png)

##2. **Create Access keys in your AWS account**

- Now, login to your aws account login console and create  access key pair. 

- Download the keypair and save it  somewhere safe. You will need this information for configuring AWS CLI later.

![alt text](awskeygenerate.png)

access key:xxxxxxxxxxxx
secret key:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

##3. **Install AWS CLI on your local laptop**

- Go to this link and download  the latest version for Windows :


> https://awscli.amazonaws.com/AWSCLIV2.msi

- Install the awscli on laptop from downloaded setup.

- Open Command Prompt and run following command to configure aws cli :

![alt text](awsversion.png)

Below are refrence urls  used while configuring aws cli :

>https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

##4. **Configure AWS on your local laptop using Access key and Secret key**
  
`aws configure`

![alt text](awscli.png)

Create terraform file main.tf with content as shown below with notepad or any text editor tool:

`notepad main.tf`

```
provider "aws" {
	access_key ="<your_access_key>"
	secret_key="<your_secret_key>"
	region = "us-east-1a"
}
```
Initilize the terraform  by running following commands in cmd : 

`terraform init`

![alt text](init.png)
![alt text](dir.png)


##5. **Create terraform script to create below infrastructure on AWS**

###VPC
--https://computingforgeeks.com/how-to-install-terraform-on-ubuntu/
--Terraform Hands-on Project — Build Your Own AWS Infrastructure with Ease using Infrastructure as Code | by Sayali Shewale | Medium
--How to Build AWS VPC & Subnets using Terraform - Step by Step (spacelift.io)
--https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc


```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
}

##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}
```
> terraform plan
> terraform validate
> terraform apply
	--YES to apply

You can also save the plan and then apply to save your plan and then apply  it later if needed.
> terraform show
> terraform plan -out=tfplan

![alt text](vpcplan.png)
![alt text](vpcapply.png)
###	Internet Gateway

```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
} 
##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.2.0/24"
  map_public_ip_on_launch = false 
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Internet Gateway"
  }
}
```
![alt text](internetgatewayplan.png)
![alt text](internetgatewayapply.png)

###	Public Subnet

```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
}
##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"

  tags = {
    Name = "Public Subnet"
  }
}
```

> terraform plan
> terraform validate
> terraform apply
--YES to apply

![alt text](publicsubnetplan.png)
![alt text](publicsubnetapply.png)

###	Private Subnet

```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
}
##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"

  tags = {
    Name = "Public Subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.2.0/24"

  tags = {
    Name = "Private Subnet"
  }
}
```

> terraform plan
> terraform validate
> terraform apply
	--YES to apply

![alt text](privatesubnetplan.png)
![alt text](privatesubnetapply.png)

###	Route Table, Internet Gateway

```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
}
##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.2.0/24"
  map_public_ip_on_launch = false 
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Main Route Table"
  }
}
```
![alt text](routetableplan.png)
![alt text](routetableapply.png)

###	Route Table Association with Subnets

![alt text](rtasso.png)
![alt text](rtassapply.png)

###	EC2 Instance
###	Security Group

![alt text](securitygroupplan.png)
![alt text](securitygroupapply.png)
![alt text](securitygroupvalidate.png)
![alt text](securitygroupapply2.png)

###	Elastic IP

```
provider "aws" {
	access_key =" "
	secret_key=" "
	region = "us-east-1"
}
##Retrive the AZ where we want to create network resources
data "aws_availability_zones" "available" {}
#VPC Resources
resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  } 
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.1.0/24"
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.11.2.0/24"
  map_public_ip_on_launch = false 
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Main Route Table"
  }
}

resource "aws_eip" "example" {
  instance = aws_instance.EC2_web_server.id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.EC2_web_server.id
  allocation_id = aws_eip.example.id
}
```

![alt text](eipplan.png)
![alt text](eipapply.png)
![alt text](eipapply2.png)

You need to pass User-data script to EC2 Instance resource group 
Section in terraform to install and run sample application using terraform
- Refer this blog for this task, also read my comment below this blog. 
>https://medium.com/@sayalishewale12/terraform-hands-on-projectbuild-your-own-aws-infrastructure-with-ease-using-infrastructure-as9f17640518

### DESTROYING the Resources

To destroy all resources created by this Terraform configuration:

`terraform destroy`

You will be asked for conformation  before proceeding with the destruction of these resources. Type `yes` when prompted to confirm each.

`Enter value = yes`

This will delete the AWS VPC, subnets, security groups, EC2 instances, EIP addresses, Internet Gateways, and Routing Tables.

![alt text](terraformdestroy.PNG)

![alt text](tfdestroy2.png)

After this you can verify in aws console that your resources are destroyed.

------------------------------------------


