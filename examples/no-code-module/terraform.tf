terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.0"
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.base-infra.outputs.region
} 