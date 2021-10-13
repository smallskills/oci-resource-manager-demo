# Variables
variable "compartment_id"              { type = string }
variable "compute_name"                { type = string }
variable "compute_subnet_id"           { type = string }
variable "compute_image_id"            { type = string }
variable "compute_ssh_authorized_keys" { type = string }

variable "compartment_nsg_id" { type = string }
variable "vcn_nsg_id" { type = string }
variable "security_groups_display_name" { type = string }
variable "rule_direction" { type = string }
variable "rule_protocol" { type = string }
variable "rule_destination" { type = string }
variable "rule_destination_type" { type = string }
variable "rule_stateless" { type = string }
variable "network_security_group_security_rule_description" { type = string }


variable "compute_shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "compute_cpus" {
  type    = string
  default = "1"
}

variable "compute_memory_in_gbs" {
  type    = string
  default = "1"
}


# Resources
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_instance" "tf_compute" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  shape               = var.compute_shape

  source_details {
    source_id         = var.compute_image_id
    source_type       = "image"
  }

  # Optional
  display_name        = var.compute_name

  shape_config {
    ocpus         = var.compute_cpus
    memory_in_gbs = var.compute_memory_in_gbs
  }

  create_vnic_details {
    subnet_id         = var.compute_subnet_id
    assign_public_ip  = true
    #nsg_ids = var.instance_create_vnic_details_nsg_ids
    nsg_ids = [
      oci_core_network_security_group.nsg.id
    ]
  }

  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
  } 

  preserve_boot_volume = false
}

resource "oci_core_network_security_group" "nsg" {
    #Required
    compartment_id = var.compartment_nsg_id
    vcn_id = var.vcn_nsg_id

    #Optional
    display_name = var.security_groups_display_name
}

resource "oci_core_network_security_group_security_rule" "network_security_group_security_rule" {
    #Required
    network_security_group_id = oci_core_network_security_group.nsg.id
    direction = var.rule_direction
    protocol = var.rule_protocol

    #Optional
    description = var.network_security_group_security_rule_description
    destination = var.rule_destination
    destination_type = var.rule_destination_type
    stateless = var.rule_stateless
}


# Outputs
output "compute_id" {
  value = oci_core_instance.tf_compute.id
}

output "instance_state" {
  value = oci_core_instance.tf_compute.state
}

output "compute_public_ip" {
  value = oci_core_instance.tf_compute.public_ip
}

output "nsg_id" {
  value = oci_core_network_security_group.nsg.id
}