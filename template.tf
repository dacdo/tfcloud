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
}
