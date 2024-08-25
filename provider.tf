terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "master-admin"
  alias   = "master-admin"
}

provider "vault" {
  # Configuration options
  address = "http://127.0.0.1:8200"
  token   = var.master-vault-token
  alias   = "master-vault"
}