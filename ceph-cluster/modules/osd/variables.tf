# variables.tf - OSD

variable "osd_instance_count" {
  type    = number
}

variable "osd_data_disk_size_gb"{
  type    = number
}

variable "gcp_data_disk_type"{
  type    = string
}


variable "gcp_region" {
  type    = string
}

variable "gcp_region_network" {
  type    = string
}

variable "gcp_default_machine_type" {
  type    = string
}

variable "gcp_default_machine_image"{
  type    = string
  description = "Default OS image for the VMs"
}