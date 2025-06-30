resource "google_compute_instance" "vm_instances" {
  count        = var.instance_count
  name         = "${var.instance_name_prefix}-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  labels = var.labels

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = var.startup_script

  tags = var.tags
}
