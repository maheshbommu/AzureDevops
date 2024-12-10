terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  count         = 2                       # Number of instances to create
  ami           = "ami-0dee22c13ea7a9a67" 
  instance_type = "t2.micro"              

  tags = {
    Name = "example-instance"
  }
}