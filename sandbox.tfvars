{
  "aws-region" : "us-east-1",
  "azs" : ["us-east-1b", "us-east-1c", "us-east-1d"],

  "management-vpc-name" : "vpc-sandbox-management",
  "management-cidr" : "10.1.0.0/16",
  "management-public-kube-subnets" : ["10.1.0.0/20","10.1.16.0/20","10.1.32.0/20"],
  "management-public-alt-subnets" : ["10.1.48.0/22","10.1.52.0/22","10.1.56.0/22"],
  "management-private-kube-subnets" : ["10.1.64.0/20","10.1.80.0/20","10.1.96.0/20"],
  "management-private-alt-subnets" : ["10.1.112.0/22","10.1.116.0/22","10.1.120.0/22"],
  "management-orchestration-kube-subnets" : ["10.1.128.0/20","10.1.144.0/20","10.1.160.0/20"],
  "management-orchestration-alt-subnets" : ["10.1.176.0/22","10.1.180.0/22","10.1.184.0/22"],

  "platform-vpc-name" : "vpc-sandbox",
  "platform-cidr" : "10.2.0.0/16",
  "platform-public-kube-subnets" : ["10.2.0.0/20","10.2.16.0/20","10.2.32.0/20"],
  "platform-public-alt-subnets" : ["10.2.48.0/22","10.2.52.0/22","10.2.56.0/22"],
  "platform-private-kube-subnets" : ["10.2.64.0/20","10.2.80.0/20","10.2.96.0/20"],
  "platform-private-alt-subnets" : ["10.2.112.0/22","10.2.116.0/22","10.2.120.0/22"],
  "platform-orchestration-kube-subnets" : ["10.2.128.0/20","10.2.144.0/20","10.2.160.0/20"],
  "platform-orchestration-alt-subnets" : ["10.2.176.0/22","10.2.180.0/22","10.2.184.0/22"],

  "ephemeral-vpc-name" : "vpc-sandbox-ephemeral",
  "ephemeral-cidr" : "10.3.0.0/16",
  "ephemeral-public-kube-subnets" : ["10.3.0.0/20","10.3.16.0/20","10.3.32.0/20"],
  "ephemeral-public-alt-subnets" : ["10.3.48.0/22","10.3.52.0/22","10.3.56.0/22"],
  "ephemeral-private-kube-subnets" : ["10.3.64.0/20","10.3.80.0/20","10.3.96.0/20"],
  "ephemeral-private-alt-subnets" : ["10.3.112.0/22","10.3.116.0/22","10.3.120.0/22"],
  "ephemeral-orchestration-kube-subnets" : ["10.3.128.0/20","10.3.144.0/20","10.3.160.0/20"],
  "ephemeral-orchestration-alt-subnets" : ["10.3.176.0/22","10.3.180.0/22","10.3.184.0/22"]
}
