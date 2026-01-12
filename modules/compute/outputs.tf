output "instance_id" {
  description = "OCID of the compute instance."
  value       = oci_core_instance.ghost.id
}

output "public_ip" {
  description = "Public IPv4 address of the instance."
  value = oci_core_instance.ghost.public_ip
  # If attribute unsupported, use this:
  # value = oci_core_instance.ghost.primary_vnic.0.public_ip_address
}