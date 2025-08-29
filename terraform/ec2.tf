# Key pair for EC2 instance
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-ec2-key"
  public_key = file("terraform-ec2-key.pub")
}

# VPC for EC2 instance
resource "aws_default_vpc" "default" {
  #   tags = {
  #     Name = "Default VPC"
  #   }
}

# Security group for EC2 instance
resource "aws_security_group" "allow_tls" {
  name        = "terraform-ec2-sg"
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
    Name = "allow_tls"
  }
}

# EC2 Instance
resource "aws_instance" "terraform_ec2" {
  count = 2 # meta argument
  ami             = var.ubuntu_ec2_ami_id # Ubuntu 24
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_tls.name]
  root_block_device {
    volume_size = var.aws_root_storage_size
    volume_type = "gp3"
  }
  user_data = file("install_nginx.sh") # Run install_nginx script

  tags = {
    Name = "terraform-ec2-instance"
  }
}