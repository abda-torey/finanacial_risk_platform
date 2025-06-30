variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "instance_count" {
  description = "Number of VM instances to create"
  type        = number
}

variable "instance_name_prefix" {
  description = "Prefix for the VM instance names"
  type        = string
  default     = "vm-instance"
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "zone" {
  description = "GCP zone to deploy VM instances"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork_name" {
  description = "Subnetwork name"
  type        = string
}

variable "boot_disk_image" {
  description = "Source image for boot disk"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230808" # Ubuntu 22.04 LTS
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 30
}

variable "labels" {
  description = "Labels to apply to the VM instances"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Network tags for the VM instances"
  type        = list(string)
  default     = []
}

variable "startup_script" {
  description = "Startup script to run on VM instance boot"
  type        = string
  default     = ""
}
