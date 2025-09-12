# This file creates the service endpoints as EC2 instances
#
# It uses the following resources from other files/modules:
#   - the variable aws_instance_type
#   - the data source aws_ami.amazon_linux.id
#   - the file "cloud-init-docker-hello-world-api.cfg"
#

# First create a network interface (it is a VPC object but for clarity is in the EC2 file)
resource "aws_network_interface" "hello-interface" {
  subnet_id       = aws_subnet.hello-net.id
  security_groups = [aws_security_group.sg-hello.id]
}

# Create an EC2 instance, install Docker in it, and run the hello-world-api container endpoint from Docker Hub mapping the service port to port 80 (single container instance)
# WARNING: This code is for cloud-init v22 as used in Amazon Linux 2023. The syntax for cloud-init v25 will change
resource "aws_instance" "ec2-docker-hello" {
  instance_type = var.aws_instance_type
  ami = data.aws_ami.amazon_linux.id
  primary_network_interface {
    network_interface_id = aws_network_interface.hello-interface.id
  }
  user_data_base64 = filebase64("cloud-init-docker-hello-world-api.cfg")

  depends_on = [aws_internet_gateway.hello-igw]
}

# Create a security group which permits HTTP and SSH to the instance
resource "aws_security_group" "sg-hello" {
  name        = "hello"
  description = "Allow access to the hello-world endpoint"
  vpc_id      = aws_vpc.hello-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-hello-http" {
  security_group_id = aws_security_group.sg-hello.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

# Currently permitting all outbound traffic to simplify things
# In a real-world scenario it would be better to permit only AWS yum and Docker Hub for security reasons
resource "aws_vpc_security_group_egress_rule" "allow-hello-ssh" {
  security_group_id = aws_security_group.sg-hello.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
