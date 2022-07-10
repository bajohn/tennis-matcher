terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# TODO create AWS profile
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile="blarb"
}

# Create a Dynamo table
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }