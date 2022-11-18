terraform {
  backend "s3" {
    encrypt = true
    key     = "tf-demo-mkdocs.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }

  required_version = "~> 1.0"
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