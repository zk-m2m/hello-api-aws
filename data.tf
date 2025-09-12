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

#
#        {
#            "BlockDeviceMappings": [
#                {
#                    "Ebs": {
#                        "DeleteOnTermination": true,
#                        "Iops": 3000,
#                        "SnapshotId": "snap-08bc74ec9ccc7f222",
#                        "VolumeSize": 8,
#                        "VolumeType": "gp3",
#                        "Throughput": 125,
#                        "Encrypted": false
#                    },
#                    "DeviceName": "/dev/xvda"
#                }
#            ],
#            "Description": "Amazon Linux 2023 AMI 2023.8.20250908.0 x86_64 HVM kernel-6.12",
#            "Name": "al2023-ami-2023.8.20250908.0-kernel-6.12-x86_64",
#            "DeprecationTime": "2025-12-05T00:43:00.000Z",
#            "ImageId": "ami-039f09c1f0127bbc5",
#            "ImageLocation": "amazon/al2023-ami-2023.8.20250908.0-kernel-6.12-x86_64",
#            "State": "available",
#            "OwnerId": "137112412989",
#            "CreationDate": "2025-09-06T00:42:47.000Z",
#            "Public": true,
#            "Architecture": "x86_64",
#            "ImageType": "machine"
#        },
#
#        {
#            "PlatformDetails": "Linux/UNIX",
#            "UsageOperation": "RunInstances",
#            "BlockDeviceMappings": [
#                {
#                    "Ebs": {
#                        "DeleteOnTermination": true,
#                        "Iops": 3000,
#                        "SnapshotId": "snap-06384095a22747d1b",
#                        "VolumeSize": 8,
#                        "VolumeType": "gp3",
#                        "Throughput": 125,
#                        "Encrypted": false
#                    },
#                    "DeviceName": "/dev/xvda"
#                }
#            ],
#            "Description": "Amazon Linux 2023 AMI 2023.8.20250908.0 x86_64 HVM kernel-6.1",
#            "Name": "al2023-ami-2023.8.20250908.0-kernel-6.1-x86_64",
#            "DeprecationTime": "2025-12-05T00:52:00.000Z",
#            "ImageId": "ami-0634f3c109dcdc659",
#            "ImageLocation": "amazon/al2023-ami-2023.8.20250908.0-kernel-6.1-x86_64",
#            "State": "available",
#            "OwnerId": "137112412989",
#            "CreationDate": "2025-09-06T00:51:30.000Z",
#            "Public": true,
#            "Architecture": "x86_64",
#            "ImageType": "machine"
#        },
#
