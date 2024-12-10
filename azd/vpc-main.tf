terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "one" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : "vpc-one"
  }
}
resource "aws_subnet" "base" {
  vpc_id            = aws_vpc.one.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name : "subnet-1"
  }


}