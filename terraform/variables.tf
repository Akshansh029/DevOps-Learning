variable "instance_type" {
  default = "t2.micro"
}

variable "aws_root_storage_size" {
  type    = number
  default = 15
}

variable "ubuntu_ec2_ami_id" {
  type    = string
  default = "ami-0360c520857e3138f"
}