variable "bucket_names" {
  description = "List of GCS bucket names to create."
  type        = list(string)
}

variable "location" {
  description = "GCS bucket location (e.g., US, EU-WEST1)."
  type        = string
  default     = "EU"
}

variable "storage_class" {
  description = "Storage class for the buckets."
  type        = string
  default     = "STANDARD"
}

variable "labels" {
  description = "Labels to apply to all buckets."
  type        = map(string)
  default     = {}
}
variable "lifecycle_days" {
  description = "Age in days to apply the lifecycle deletion rule."
  type        = number
  default     = 30
}

variable "uniform_access" {
  description = "Enforce uniform bucket-level access."
  type        = bool
  default     = true
}