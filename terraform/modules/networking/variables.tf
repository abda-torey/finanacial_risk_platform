variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "region" {
  description = "Region where the subnet is created"
  type        = string
}

variable "labels" {
  description = "Labels to apply to network resources"
  type        = map(string)
  default     = {}
}
