# Provider configuration
provider "aws" {
  region = "us-east-1" # Specify the region
}

# Create a new security group that allows all inbound and outbound traffic
resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Security group that allows all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami             = "ami-005fc0f236362e99f"
  instance_type   = "t2.medium"
  key_name        = "ec2key"
  security_groups = [aws_security_group.allow_all.name]

  # Configure root block device
  root_block_device {
    volume_size = 30

  }

  tags = {
    Name = "MyUbuntuInstance"
  }
}