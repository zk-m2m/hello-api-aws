# This file adds and configures the Terraform providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "dev"
  region = "us-east-2"
}
