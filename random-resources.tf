resource "random_string" "random-string-gen" {
  upper   = false
  length  = 6
  special = false
  numeric = false
}