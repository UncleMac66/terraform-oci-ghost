data "template_file" "user_data" {
  template = file(var.user_data_path)
}

resource "oci_core_instance" "ghost" {
  compartment_id = var.compartment_ocid
  availability_domain = var.availability_domain
  shape = var.instance_shape

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_memory_in_gbs
  }

  display_name = var.instance_display_name

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
    hostname_label   = var.hostname_label
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  source_details {
    source_type = "image"
    source_id   = var.source_id
    # source_id should be the OCID of the Oracle-provided image, e.g., Oracle-Linux-8
  }
}

resource "oci_core_vnic_attachment" "ghost" {
  instance_id         = oci_core_instance.ghost.id
  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }
}