terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
  required_version = ">= 1.2.5"
}

locals {
  s3_bucket_name = "ruzickap-test-iac"
  aws_region     = "eu-central-1"
  aws_default_tags = {
    test = "1234"
  }
}

provider "aws" {
  default_tags {
    tags = local.aws_default_tags
  }
  region = local.aws_region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket        = local.s3_bucket_name
  force_destroy = true

  versioning {
    enabled = false
  }
}
