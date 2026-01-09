resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn_cidr
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "internet-gateway"
  enabled        = true
}

resource "oci_core_nat_gateway" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "nat-gateway"
  block_traffic  = false
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "public-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

resource "oci_core_route_table" "private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "private-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.this.id
  }
}

resource "oci_core_subnet" "public" {
  compartment_id       = var.compartment_ocid
  vcn_id               = oci_core_vcn.this.id
  cidr_block           = var.public_subnet_cidr
  display_name         = "public-subnet"
  route_table_id       = oci_core_route_table.public.id
  dns_label            = var.public_subnet_dns_label
  security_list_ids    = [oci_core_security_list.public.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_subnet" "private" {
  compartment_id       = var.compartment_ocid
  vcn_id               = oci_core_vcn.this.id
  cidr_block           = var.private_subnet_cidr
  display_name         = "private-subnet"
  route_table_id       = oci_core_route_table.private.id
  dns_label            = var.private_subnet_dns_label
  security_list_ids    = [oci_core_security_list.private.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "public-sg"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
    description = "Allow SSH"
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
    description = "Allow HTTP"
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
    description = "Allow HTTPS"
  }
  
}

resource "oci_core_security_list" "private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "private-sg"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  # Only allow internal access on all TCP (between subnets)
  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_cidr
    description = "Allow TCP from within VCN"
  }
}