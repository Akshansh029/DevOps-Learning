variable "instance_type" {
  default = "t2.micro"
}

variable "aws_default_root_storage_size" {
  type    = number
  default = 10
}

variable "aws_root_storage_size" {
  type    = number
  default = 20
}

variable "ubuntu_ec2_ami_id" {
  type    = string
  default = "ami-0360c520857e3138f"
}

variable "env" {
  type = string
  default = "prd"
}