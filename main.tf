terraform {
  backend "s3" {
    encrypt = true
    key     = "tf-demo-mkdocs.tfstate"
  }
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  global_tags = {
    CreatedBy   = "demo-mkdocs"
    Provisioner = "Terraform"
    Env         = var.env
  }
}