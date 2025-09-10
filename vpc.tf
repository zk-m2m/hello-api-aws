# This file creates the software-defined networking in AWS

# Add an AWS Virtual Private Cloud (VPC)
resource "aws_vpc" "hello-vpc" {
  cidr_block = "10.1.0.0/16"
}

# Add an IPv4 subnet in the VPC
resource "aws_subnet" "hello-net" {
  vpc_id     = aws_vpc.hello-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
}

# Add an AWS Internet Gateway to route traffic to public addresses
resource "aws_internet_gateway" "hello-igw" {
  vpc_id = aws_vpc.hello-vpc.id
}

# Add a route to the IGW to reach the Internet
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.hello-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hello-igw.id
  }
}
