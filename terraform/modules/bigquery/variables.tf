variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "dataset_id" {
  description = "The BigQuery dataset ID"
  type        = string
}

variable "location" {
  description = "The location for the BigQuery dataset"
  type        = string
  default     = "EU"
}

variable "friendly_name" {
  description = "A friendly name for the dataset"
  type        = string
  default     = ""
}

variable "description" {
  description = "A description for the dataset"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to the dataset"
  type        = map(string)
  default     = {}
}

variable "delete_contents_on_destroy" {
  description = "Whether to delete contents when destroying the dataset"
  type        = bool
  default     = true
}

variable "access" {
  description = "List of access blocks"
  type = list(object({
    role          = string
    user_by_email = string
  }))
  default = null
}
