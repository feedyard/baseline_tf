# The baseline account configuration for the reference architecture
# CONFIRM: all resources managed by terraform are tagged as such to assit in diagnosing errors.

module "vpc-context" {
  source = "mod_context"

  name = "${var.context-vpc-name}"
  cidr = "${var.context-cidr}"
  azs = "${var.context-azs}"

  public_kube_subnets = "${var.context-public-kube-subnets}"
  public_alt_subnets = "${var.context-public-alt-subnets}"

  private_kube_subnets = "${var.context-private-kube-subnets}"
  private_alt_subnets = "${var.context-private-alt-subnets}"

  orchestration_kube_subnets = "${var.context-orchestration-kube-subnets}"
  orchestration_alt_subnets = "${var.context-orchestration-alt-subnets}"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags {
    "terraform" = "true"
    "environment" = "${terraform.env}"
  }
}
