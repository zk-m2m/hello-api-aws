# This file contains various parameters to avoid hard-coding them

# Select the AWS Free Tier EC2 instance type
variable "aws_instance_type" {
  type        = string
  description = "EC2 instance type for AWS Free Tier"
  default     = "t3.micro"
}
