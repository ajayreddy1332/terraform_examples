provider "aws" { 
  region = "us-west-2" 
} 
resource "aws_vpc" "my_vpc" { 
  cidr_block = "10.0.0.0/16" 
 tags {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "public" { 
    vpc_id = "${aws_vpc.my_vpc.id}" 
    cidr_block = "10.0.1.0/24" 
 tags {
    Name = "my-subnet"
  }
}

resource "aws_security_group" "allow_http" { 
  name = "allow_http" 
  description = "Allow HTTP traffic" 
  vpc_id = "${aws_vpc.my_vpc.id}" 
 
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
 
resource "aws_instance" "mighty-trousers" { 
  ami = "ami-223f945a" 
  instance_type = "t2.micro" 
  subnet_id = "${aws_subnet.public.id}" 
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"] 
} 