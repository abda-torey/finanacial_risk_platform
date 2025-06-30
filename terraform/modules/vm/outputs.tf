output "instance_names" {
  description = "Names of the created VM instances"
  value       = [for instance in google_compute_instance.vm_instances : instance.name]
}

output "instance_self_links" {
  description = "Self-links of the created VM instances"
  value       = [for instance in google_compute_instance.vm_instances : instance.self_link]
}

output "instance_ips" {
  description = "External IPs of the VM instances"
  value       = [for instance in google_compute_instance.vm_instances : instance.network_interface[0].access_config[0].nat_ip]
}
