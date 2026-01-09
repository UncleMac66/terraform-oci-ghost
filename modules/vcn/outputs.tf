output "vcn_id" {
  description = "The OCID of the created VCN."
  value       = oci_core_vcn.this.id
}

output "vcn_cidr_block" {
  description = "The VCN CIDR block."
  value       = oci_core_vcn.this.cidr_block
}

output "public_subnet_id" {
  description = "The OCID of the public subnet."
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "The OCID of the private subnet."
  value       = oci_core_subnet.private.id
}

output "public_security_list_id" {
  description = "The OCID of the public security list."
  value       = oci_core_security_list.public.id
}

output "private_security_list_id" {
  description = "The OCID of the private security list."
  value       = oci_core_security_list.private.id
}