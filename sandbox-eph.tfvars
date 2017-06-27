{
  "context_aws_region" : "us-east-1",
  "context_azs" : ["us-east-1b", "us-east-1c", "us-east-1d"],
  
  "context_vpc_name" : "vpc-sandbox-ephemeral",
  "context_cidr" : "10.23.0.0/16",

  "context_public_kube_subnets" : ["10.23.0.0/20","10.23.16.0/20","10.23.32.0/20"],
  "context_public_alt_subnets" : ["10.23.48.0/22","10.23.52.0/22","10.23.56.0/22"],
  "context_private_kube_subnets" : ["10.23.64.0/20","10.23.80.0/20","10.23.96.0/20"],
  "context_private_alt_subnets" : ["10.23.112.0/22","10.23.116.0/22","10.23.120.0/22"],
  "context_orchestration_kube_subnets" : ["10.23.128.0/20","10.23.144.0/20","10.23.160.0/20"],
  "context_orchestration_alt_subnets" : ["10.23.176.0/22","10.23.180.0/22","10.23.184.0/22"],

  "context_vpc_id" : "vpc-1a6ad463",
  "context_management_vpc_id" : "vpc-a66ed0df",
  "context_management_acct_id" : "750464328775",
  "context_is_management" : "false",
  "context_route_to_vpc_cidr" : ["10.21.0.0/16"],
  "context_route_to_vpc_pcx" : ["pcx-bb1165d2"],
  "context_management_sg_admin" : "sg-d82886a9",
  "context_sg_node" : "sg-f9208e88",
  "context_sg_private" : "sg-91208ee0"
}
