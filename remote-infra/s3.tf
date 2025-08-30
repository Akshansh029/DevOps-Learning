resource "aws_s3_bucket" "terraform_remote_infra_bucket" {
  bucket = "terraform-remote-infra-bucket-akshansh029"

  tags = {
      Name = "terraform-remote-infra-bucket-akshansh029"
  }
}