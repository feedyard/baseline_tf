variable "name" {}

variable "vpc_id" {}

variable "is_management" {
  description = "the env is a management vpc"
  default     = "false"
}

variable "admin_sg" {
  description = "id for allowing access from admin sg"
  default = "unused"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}