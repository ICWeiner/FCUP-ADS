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

variable "osd_instance_count" {
  type    = number
  description = "Default count of OSD instances"
}

variable "gcp_default_machine_type" {
  type    = string
}

variable "gcp_default_machine_image"{
  type    = string
  description = "Default OS image for the VMs"
}