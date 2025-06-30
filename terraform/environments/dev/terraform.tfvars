# Required values (no defaults in variables.tf)

gcp_project_id = "financial-anomaly-464319"
data_bucket_name = [
  "dev-raw-data-bucket",
  "dev-streaming-input-bucket-financial-anomaly-464319",
  "dev-processed-data-bucket-financial-anomaly-464319",
  "dev-analytics-export-bucket-financial-anomaly-464319",
  "dev-logs-bucket-financial-anomaly-464319"
]

# Optional value (override defaults only if needed)

gcp_region = "eu-west2"
gcp_zone   = "eu-west2-a"
env_prefix = "dev"

network_name = "dev-vpc-network"
subnet_cidr  = "10.0.0.0/20"

vm_instance_count = 1
vm_machine_type   = "e2-medium"
boot_disk_image   = "ubuntu-os-cloud/ubuntu-2204-lts"
boot_disk_size    = 30


data_bucket_location = "EU-WEST2"

bq_dataset_id = "dev_financial_analytics_dataset"
