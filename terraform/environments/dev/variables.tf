
variable "gcp_project_id" {
  description = "The GCP project ID for the Dev environment."
  type        = string
  # No default here; it should be explicitly set in terraform.tfvars.
}

variable "gcp_region" {
  description = "The default GCP region for resources in the Dev environment."
  type        = string
  default     = "eu-west1" # Example default, adjust as per your preference
}

variable "gcp_zone" {
  description = "The default GCP zone for zonal resources in the Dev environment (e.g., VMs)."
  type        = string
  default     = "eu-west1-a" # Example default, adjust as per your preference
}

variable "env_prefix" {
  description = "A short prefix used for resource naming to denote the environment (e.g., 'dev', 'stg', 'prd')."
  type        = string
  default     = "dev" # Default for the dev environment
}

# --- Networking Module Variables ---
variable "network_name" {
  description = "Name of the VPC network."
  type        = string
  default     = "dev-vpc-network"
}

variable "subnet_cidr" {
  description = "CIDR range for the primary subnet in the VPC."
  type        = string
  default     = "10.0.0.0/20"
}

# --- VM Module Variables ---
variable "vm_instance_count" {
  description = "Number of VM instances to deploy for the application."
  type        = number
  default     = 1
}

variable "vm_machine_type" {
  description = "Machine type for the VM instances."
  type        = string
  default     = "e2-medium"
}
variable "boot_disk_image" {
  description = "Source image for boot disk"
  type        = string
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
}
# --- GCS Bucket Module Variables ---
variable "data_bucket_name" {
  description = "Globally unique name for the primary data GCS bucket."
  type        = list(string)
  # No default here, MUST be set in terraform.tfvars due to global uniqueness
}

variable "data_bucket_location" {
  description = "Location for the GCS bucket (e.g., 'US', 'EUROPE', 'ASIA-SOUTH1')."
  type        = string
  default     = "EU-WEST1"
}

# --- BigQuery Module Variables biqury---
variable "bq_dataset_id" {
  description = "The ID for the BigQuery dataset."
  type        = string
  default     = "dev_financial_analytics_dataset"
}

