variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "us-west-2"
}

# Use the namespace to customize your bucketname e.g. username
variable "namespace" {}