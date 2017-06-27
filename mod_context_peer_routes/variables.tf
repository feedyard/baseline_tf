variable "public_route_table_ids" {
  description = "list of public route tables in context-vpc"
  type = "list"
}

variable "private_route_table_ids" {
  description = "list of private route tables in context-vpc"
  type = "list"
}

variable "is_management" {
  description = "the env is a management vpc"
  default     = "false"
}

variable "route_to_vpc_cidr"  {
  description = "module will loop through public and private route tables adding routes to vpc-management"
  default = []
}

variable "route_to_vpc_pcx"  {
  description = "matching list of pcx-ids to go with each cidr block"
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}