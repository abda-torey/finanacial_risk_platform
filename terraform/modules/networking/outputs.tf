output "network_name" {
  description = "The name of the created VPC network"
  value       = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
  description = "The name of the created subnetwork"
  value       = google_compute_subnetwork.subnet.name
}

output "network_self_link" {
  description = "Self-link of the created VPC network"
  value       = google_compute_network.vpc_network.self_link
}
