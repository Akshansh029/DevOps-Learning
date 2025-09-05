resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.env}-${var.infra-app-dynamo-table-name}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.infra-app-dynamo-table-hashkey

  attribute {
    name = var.infra-app-dynamo-table-hashkey
    type = "S"
  }

  tags = {
    Name        = var.infra-app-dynamo-table-name
    Environment = var.env
  }
}