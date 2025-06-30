provider "google" {

  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "networking" {
  source       = "../../modules/networking"
  project_id   = var.gcp_project_id
  region       = var.gcp_region
  network_name = var.network_name
  subnet_cidr  = var.subnet_cidr
  labels = {
    env     = var.env_prefix
    project = var.gcp_project_id
  }
}

module "vm" {
  source          = "../../modules/vm"
  project_id      = var.gcp_project_id
  instance_count  = var.vm_instance_count
  machine_type    = var.vm_machine_type
  network_name    = module.networking.network_name
  subnetwork_name = module.networking.subnetwork_name
  zone            = var.gcp_zone

  boot_disk_image = "ubuntu-os-cloud/ubuntu-2204-lts" # Ubuntu 22.04 LTS image
  boot_disk_size  = 30
  labels = {
    env     = var.env_prefix
    project = var.gcp_project_id
  }
}

module "gcs_buckets" {
  source       = "../../modules/gcs_bucket"
  bucket_names = var.data_bucket_name
  location     = var.data_bucket_location
  labels = {
    env     = var.env_prefix
    project = var.gcp_project_id
  }
}

module "bigquery" {
  source     = "../../modules/bigquery"
  project_id = var.gcp_project_id
  dataset_id = var.bq_dataset_id
  location   = var.gcp_region

  friendly_name = "Financial Analytics Dataset"
  description   = "Dataset for storing and querying historical financial data."

  labels = {
    env     = var.env_prefix
    project = var.gcp_project_id
  }

  delete_contents_on_destroy = true

  access = [
    {
      role          = "READER"
      user_by_email = "analyst@example.com"
    },
    {
      role          = "WRITER"
      user_by_email = "engineer@example.com"
    }
  ]
}
