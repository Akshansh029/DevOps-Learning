module "dev-infra" {
  source = "./app"
  env = "dev"
  infra-app-instance-name = "infra-app-instance"
  infra-app-ec2-count = 1
  infra-app-ec2-instance-type = "t2.micro"
  infra-app-bucket-name = "infra-app-bucket"
  infra-app-dynamo-table-name = "infra-app-dynamo-table"
  infra-app-dynamo-table-hashkey = "LockID"
}