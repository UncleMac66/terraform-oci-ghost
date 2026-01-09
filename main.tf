module "vcn" {
  source               = "./modules/vcn"
  compartment_ocid     = var.compartment_ocid
  vcn_cidr             = var.vcn_cidr
  vcn_display_name     = "ghost-vcn"
  vcn_dns_label        = "ghostvcn"
  public_subnet_cidr   = var.public_subnet_cidr
  public_subnet_dns_label = "pubsubnet"
  private_subnet_cidr  = var.private_subnet_cidr
  private_subnet_dns_label = "privsubnet"
}

module "ghost_compute" {
  source            = "./modules/compute"
  compartment_ocid  = var.compartment_ocid
  availability_domain = var.availability_domain # Must be set (see README)
  instance_shape      = var.instance_shape
  instance_ocpus      = var.instance_ocpus
  instance_memory_in_gbs = var.instance_memory_in_gbs
  instance_display_name  = var.instance_display_name
  subnet_id              = module.vcn.public_subnet_id
  hostname_label         = var.hostname_label
  source_id              = var.source_id
  ssh_public_key         = var.ssh_public_key
  user_data_path         = var.user_data_path
}