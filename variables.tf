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
  region = "${var.context_aws_region}"
}

variable "context_aws_region" {}
variable "context_azs" { type = "list" }

variable "context_vpc_name" {}
variable "context_cidr" {}
variable "context_public_kube_subnets" { type = "list" }
variable "context_public_alt_subnets" { type = "list" }
variable "context_private_kube_subnets" { type = "list" }
variable "context_private_alt_subnets" { type = "list" }
variable "context_orchestration_kube_subnets" { type = "list" }
variable "context_orchestration_alt_subnets" { type = "list" }
variable "context_is_management" {}

# Once the vpc configuration has been deployed and vpc_id's are avaialable
# then the peering portion can be enabled
variable "context_vpc_id" {}
variable "context_management_vpc_id" {}
variable "context_management_acct_id" {}

variable "context_route_to_vpc_cidr" { type = "list" }
variable "context_route_to_vpc_pcx" { type = "list" }

# security groups definitions
variable "context_management_sg_admin" {}
variable "context_sg_node" {}
variable "context_sg_private" {}
