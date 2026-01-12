output "ghost_instance_id" {
  description = "OCID of the deployed Ghost compute instance."
  value       = module.ghost_compute.instance_id
}

output "ghost_public_ip" {
  description = "Public IPv4 address of the deployed Ghost instance."
  value       = module.ghost_compute.public_ip
}