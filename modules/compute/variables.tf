variable "compartment_ocid" {
  description = "The OCID of the compartment in which to launch the compute instance."
  type        = string
}

variable "availability_domain" {
  description = "The availability domain where the instance should be launched (e.g., 'jLaG:US-ASHBURN-AD-1')."
  type        = string
}

variable "instance_shape" {
  description = "Instance shape (Flex recommended, e.g., 'VM.Standard.E6.Flex')."
  type        = string
  default     = "VM.Standard.E6.Flex"
}

variable "instance_ocpus" {
  description = "Number of OCPUs for the instance."
  type        = number
  default     = 8
}

variable "instance_memory_in_gbs" {
  description = "Memory in GBs for the instance."
  type        = number
  default     = 128
}

variable "instance_display_name" {
  description = "Display name for the compute instance."
  type        = string
}

variable "subnet_id" {
  description = "OCID of the subnet in which to launch the compute instance."
  type        = string
}

variable "hostname_label" {
  description = "Hostname label for the instance VNIC."
  type        = string
}

variable "source_id" {
  description = "OCID of the custom or Oracle-provided compute image (e.g., Oracle-Linux-8)."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content to add to the instance."
  type        = string
}

variable "user_data_path" {
  description = "Path to the cloud-init script for Docker/Ghost."
  type        = string
  default     = "../../cloud-init/ghost-init.sh"
}