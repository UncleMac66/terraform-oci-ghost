variable "compartment_ocid" {
  description = "The OCID of the compartment in which to create network resources."
  type        = string
}

variable "vcn_cidr" {
  description = "The CIDR block for the VCN."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vcn_display_name" {
  description = "Display name for the VCN."
  type        = string
  default     = "ghost-vcn"
}

variable "vcn_dns_label" {
  description = "DNS label for the VCN."
  type        = string
  default     = "ghostvcn"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_dns_label" {
  description = "DNS label for the public subnet."
  type        = string
  default     = "pubsubnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_dns_label" {
  description = "DNS label for the private subnet."
  type        = string
  default     = "privsubnet"
}