variable "env" {
  type = string
  description = "This is the name of the env for the Infra app"
}

variable "infra-app-instance-name" {
      description = "This is the name of EC2 instances"
}

variable "infra-app-ec2-count" {
      description = "This is the count of EC2 instances"
  type = number
}

variable "infra-app-ec2-instance-type" {
  description = "This is the type of EC2 instance for Infra app"
}

variable "infra-app-ec2_ami_id" {
  type    = string
  default = "ami-0360c520857e3138f" # Ubuntu ami-id
}

variable "infra-app-bucket-name" {
  description = "This is the s3 bucket name of Infra app"
  type = string
}

variable "infra-app-dynamo-table-name" {
  description = "This is the table name of the Infra app dynamo table"
}

variable "infra-app-dynamo-table-hashkey" {
  description = "This is the hash key of the Infra app dynamo table"
}