variable "name" {}

variable "cidr" {}

variable "public_kube_subnets" {
  description = "The list of subnets for the public-kube"
  default     = []
}

variable "public_alt_subnets" {
  description = "The list of subnets for the public-alt"
  default     = []
}

variable "private_kube_subnets" {
  description = "The list of subnets for the private-kube"
  default     = []
}

variable "private_alt_subnets" {
  description = "The list of subnets for the private-alt"
  default     = []
}

variable "orchestration_kube_subnets" {
  description = "The list of subnets for the orchestration-kube"
  default     = []
}

variable "orchestration_alt_subnets" {
  description = "The list of subnets for the orchestration-alt"
  default     = []
}

variable "enable_nat_gateway" {
  description = "should be true to provision NAT Gateways for each private network"
  default     = false
}

variable "enable_dns_hostnames" {
  description = "should be true to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true to use private DNS within the VPC"
  default     = false
}

variable "azs" {
  description = "The list of Availability zones in the region to span"
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "should be true if you do want to auto-assign public IP on launch"
  default     = false
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
