# Key pair for EC2 instance
resource "aws_key_pair" "key-deployer" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("${path.module}/terraform-ec2-key.pub")

  tags = {
    Environment = var.env
  }
}

# VPC for EC2 instance
resource "aws_default_vpc" "default" {
  #   tags = {
  #     Name = "Default VPC"
  #   }
}

# Security group for EC2 instance
resource "aws_security_group" "allow_tls" {
  name        = "${var.env}-infra-app-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id # Interpolation

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from anywhere"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access to HTTP from anywhere"
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-infra-app-sg"
  }
}

# EC2 Instance
resource "aws_instance" "terraform_ec2" {
  count = var.infra-app-ec2-count
  ami             = var.infra-app-ec2_ami_id # Ubuntu 24
  instance_type   = var.infra-app-ec2-instance-type
  key_name        = aws_key_pair.key-deployer.key_name
  security_groups = [aws_security_group.allow_tls.name]
  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
  }
  # user_data = file("install_nginx.sh") # Run install_nginx script

  tags = {
    Name = "${var.env}-${var.infra-app-instance-name}"
    Environment = var.env
  }
}