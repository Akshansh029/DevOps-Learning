resource "local_file" "my_file" {
  filename = "example.txt"
  content  = "First file created with Terraform"
}