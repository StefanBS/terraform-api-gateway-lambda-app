terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      owner   = "Stefan"
      project = "Cytora coding test"
    }
  }
}
