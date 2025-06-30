resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)

  name     = each.value
  location = var.location

  storage_class               = var.storage_class
  labels                      = var.labels
  uniform_bucket_level_access = var.uniform_access

  lifecycle_rule {
    condition {
      age = var.lifecycle_days
    }
    action {
      type = "Delete"
    }
  }

  # Allows deleting non-empty buckets during destroy
  force_destroy = true
}