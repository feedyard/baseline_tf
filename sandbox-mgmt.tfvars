{
  "context_aws_region" : "us-east-1",
  "context_azs" : ["us-east-1b", "us-east-1c", "us-east-1d"],

  "context_vpc_name" : "vpc-sandbox-management",
  "context_cidr" : "10.21.0.0/16",

  "context_public_kube_subnets" : ["10.21.0.0/20","10.21.16.0/20","10.21.32.0/20"],
  "context_public_alt_subnets" : ["10.21.48.0/22","10.21.52.0/22","10.21.56.0/22"],
  "context_private_kube_subnets" : ["10.21.64.0/20","10.21.80.0/20","10.21.96.0/20"],
  "context_private_alt_subnets" : ["10.21.112.0/22","10.21.116.0/22","10.21.120.0/22"],
  "context_orchestration_kube_subnets" : ["10.21.128.0/20","10.21.144.0/20","10.21.160.0/20"],
  "context_orchestration_alt_subnets" : ["10.21.176.0/22","10.21.180.0/22","10.21.184.0/22"],

  "context_vpc_id" : "vpc-fb6ed082",
  "context_management_vpc_id" : "vpc-a66ed0df",
  "context_management_acct_id" : "750464328775",
  "context_is_management" : "true",
  "context_route_to_vpc_cidr" : ["10.22.0.0/16","10.23.0.0/16"],
  "context_route_to_vpc_pcx" : ["pcx-c81064a1","pcx-bb1165d2"],
  "context_management_sg_admin" : "sg-d82886a9",
  "context_sg_node" : "sg-e5268894",
  "context_sg_private" : "sg-8e2d83ff"
}
