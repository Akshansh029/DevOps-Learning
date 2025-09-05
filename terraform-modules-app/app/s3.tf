resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "${var.env}-${var.infra-app-bucket-name}-029"
}