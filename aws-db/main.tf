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

resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Allow MySQL inbound traffic"

  ingress {
    from_port   = 3306 # MySQL port
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mydb" {
  allocated_storage   = 20            
  engine              = "mysql"       
  engine_version      = "5.7"        
  instance_class      = "db.t3.micro" # Instance type
  username            = "mahesh"      # Admin username
  password            = "mahesh@123"  # Admin password
  skip_final_snapshot = true          

  vpc_security_group_ids = [aws_security_group.rds_sg.id] # Security group for RDS

  tags = {
    Name = "MyRDSInstance"
  }
}

output "db_instance_endpoint" {
  value = aws_db_instance.mydb.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.mydb.id
}