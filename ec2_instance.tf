provider "aws" {
      region = "us-west-2"
 #     access_key = "AKIAIEFN6LYYQ4KJ5JRQ
    }
# Resource configuration 
resource "aws_instance" "test-instance" { 
  ami = "ami-223f945a" 
  instance_type = "t2.micro" 
  tags { 
    Name = "test" 
  } 
} 
