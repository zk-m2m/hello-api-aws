# This file provides information from data sources

# Find the latest Amazon Linux AMI
#* See https://github.com/hashicorp-education/learn-terraform-aws-asg/blob/main/main.tf
#* 
data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]

  filter {
    name   = "free-tier-eligible"
    values = [true]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.12-x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  most_recent = true
}
