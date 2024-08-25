variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "master-vault-token" {
  type        = string
  description = "token of master vault server"
}