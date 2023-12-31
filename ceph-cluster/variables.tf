# variables.tf

variable "gcp_credentials_path" {
  type    = string
  description = "path to file containing json credetials"
}

variable "gcp_project_id" {
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


variable "osd_instance_count" {
  type    = number
  description = "Default count of OSD instances"
}

variable "osd_data_disk_size_gb"{
  type    = number
}

variable "gcp_data_disk_type"{
  type    = string
}