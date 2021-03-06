provider "aws" {
  region = "us-west-2"
}
resource "aws_vpc" "dd_vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.dd_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.dd_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}

terraform {
  backend "remote" {
    organization = "DTT"

    workspaces {
      name = "tfcloud"
    }
  }
}
resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id = aws_vpc.dd_vpc.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "dev-vm1" {
  ami = "ami-000d6375f955d3d80"
  subnet_id = aws_subnet.subnet1.id
  instance_type = lookup(var.inst_type, var.env)
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = {
    Name = "DacDo"
  }
}
resource "aws_instance" "dev-vm2" {
  ami = "ami-018e347dfe0c44534"
  subnet_id = aws_subnet.subnet2.id
  instance_type = lookup(var.inst_type, var.env)
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = {
    Name = "ThuyVu"
  }
}
