# The baseline account configuration for the reference architecture
# CONFIRM: all resources managed by terraform are tagged as such to assit in diagnosing errors.

module "context_vpc" {
  source = "mod_context_vpc"

  name = "${var.context_vpc_name}"
  cidr = "${var.context_cidr}"
  azs = "${var.context_azs}"

  public_kube_subnets = "${var.context_public_kube_subnets}"
  public_alt_subnets = "${var.context_public_alt_subnets}"

  private_kube_subnets = "${var.context_private_kube_subnets}"
  private_alt_subnets = "${var.context_private_alt_subnets}"

  orchestration_kube_subnets = "${var.context_orchestration_kube_subnets}"
  orchestration_alt_subnets = "${var.context_orchestration_alt_subnets}"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags {
    "terraform" = "true"
    "environment" = "${terraform.env}"
  }
}

# Below this line commented out on first deployment to prod context
#
# First deploy the vpc's
# Once these are in place the vpc peering connections can be added
#
# update the following lines in the #.tfvars environment vars with the mgmt ID and vpc-id infromation
#
#  "context_vpc_id" : "vpc-tbd",
#  "context_management_vpc_id" : "vpc-tbd",
#  "context_management_acct_id" : "123456789012",
#  "context_is_management" : "true",
#}
#

## stage 2
resource "aws_vpc_peering_connection" "standard_to_management" {
  count = "${var.context_is_management == "true" ? 0 : 1}"
  peer_owner_id = "${var.context_management_acct_id}"
  peer_vpc_id   = "${var.context_management_vpc_id}"
  vpc_id        = "${var.context_vpc_id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    "Name" = "peer-${var.context_vpc_name}-to-vpc-management"
    "terraform" = "true"
    "environment" = "${terraform.env}"
  }
}

# Below this line commented out on first and second deployment to prod context
#
# After the vpc's and the peering connections are deployed security groups, routes to/from management, and shared storage can be added
#
# update the following lines in the #.tfvars environment vars with the mgmt ID and vpc-id infromation
#
#  "context_route_to_vpc_cidr" : ["10.22.0.0/16","10.23.0.0/16"],   <= vpc-managment example
#  "context_route_to_vpc_pcx" : ["pcx-tbd","pcx-tbd"]
#
#}
#
# and as above, you deploy first to managment context, then update the following lines in *tfvars
#   "context_management_sg_admin" : "sg-id",
#
#}

## stage 3
module "vpc_context_peer_routes" {
  source = "mod_context_peer_routes"

  public_route_table_ids = "${module.context_vpc.public_route_table_ids}"
  private_route_table_ids = "${module.context_vpc.private_route_table_ids}"
  route_to_vpc_pcx = "${var.context_route_to_vpc_pcx}"
  route_to_vpc_cidr = "${var.context_route_to_vpc_cidr}"
  is_management = "${var.context_is_management}"

}

module "context_vpc_sg" {
  source = "mod_context_sg"

  name = "${var.context_vpc_name}"
  vpc_id = "${module.context_vpc.vpc_id}"
  is_management = "${var.context_is_management}"
  admin_sg = "${var.context_management_sg_admin}"

  tags {
    "terraform" = "true"
    "environment" = "${terraform.env}"
  }
}

module "efs_location" {

  # CONFIRM: org specific repo location for terrafrom modules
  source = "github.com/feedyard/tf_aws_efs?ref=v1.0.0"

  creation_token = "${var.context_vpc_name}-efs-share"
  subnet_id = "${element(module.context_vpc.private_alt_subnets, 1)}"

  security_groups = ["${module.context_vpc_sg.vpc_sg_alt_id}"]

  tags {
    "terraform" = "true"
    "environment" = "${terraform.env}"
  }
}

# Finally, update the following lines in *.tfvars for testing purposes
#
#  "context_sg_node" : "sg-id",
#  "context_sg_private" : "sg-id"
#}
# you should get a green results for all awspec tests