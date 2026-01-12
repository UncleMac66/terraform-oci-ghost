variable "compartment_ocid" {
  description = "The OCID of the compartment where resources should be created."
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet (load balancer)."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet (compute instance)."
  type        = string
  default     = "10.0.2.0/24"
}

variable "ssh_public_key" {
  description = "Public SSH key to be installed on the compute instance."
  type        = string
}

variable "instance_shape" {
  description = "Instance shape for the compute instance."
  type        = string
  default     = "VM.Standard.E6.Flex"
}

variable "availability_domain" {
  description = "The availability domain where the instance should be launched (e.g. 'jLaG:US-ASHBURN-AD-2')."
  type        = string
}

variable "instance_ocpus" {
  description = "Number of OCPUs for the compute instance."
  type        = number
  default     = 8
}

variable "instance_memory_in_gbs" {
  description = "Amount of memory (in GBs) for the compute instance."
  type        = number
  default     = 128
}

variable "instance_display_name" {
  description = "Display name for the compute/Ghost instance."
  type        = string
  default     = "ghost-blog"
}

variable "hostname_label" {
  description = "Hostname label for the VM."
  type        = string
  default     = "ghost"
}

variable "source_id" {
  description = "OCID of the Oracle Linux/Ubuntu image you want as the base VM."
  type        = string
}

variable "user_data_path" {
  description = "Path to the cloud-init script for provisioning the instance."
  type        = string
  default     = "cloud-init/ghost-init.sh"
}