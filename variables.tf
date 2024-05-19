variable "aws_access_key" {
 sensitive = true
}
variable "aws_secret_key" {
 sensitive = true
}
output "accesskey_value" {
 value = var.aws_access_key
 sensitive = true
}
output "secret_value" {
 value = var.aws_secret_key
 sensitive = true
}
