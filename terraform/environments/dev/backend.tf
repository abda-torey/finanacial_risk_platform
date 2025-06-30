# backend.tf
terraform {
  backend "gcs" {
    bucket = "dev-financial-anomaly-464319-2890194e5df5" 
    prefix = "terraform/state/dev"
  }
}