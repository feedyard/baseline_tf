terraform {
  required_version = ">= 0.9.0"

  backend "s3" {

    # CONFIRM: correct bucket and key path
    bucket = "feedyard-sandbox-terraform-state"
    key    = "baseline/baseline.tfstate"
  }
}

# The reference architecture assumes the bootstrap network lives in the AWS Production account
# and credentials set in the ENV
provider "aws" {
  region = "${var.context-aws-region}"
}

variable "context-aws-region" {}
variable "context-azs" { type = "list" }

variable "context-vpc-name" {}
variable "context-cidr" {}
variable "context-public-kube-subnets" { type = "list" }
variable "context-public-alt-subnets" { type = "list" }
variable "context-private-kube-subnets" { type = "list" }
variable "context-private-alt-subnets" { type = "list" }
variable "context-orchestration-kube-subnets" { type = "list" }
variable "context-orchestration-alt-subnets" { type = "list" }

