# variables.tf

variable "gcp_credentials_path" {
  type    = string
  default = "~/Documents/sys-admin-project-402817-f324568b3320.json"
}

variable "gcp_project_id" {
  type    = string
  default = "sys-admin-project-402817"
}

variable "gcp_region" {
  type    = string
  default = "europe-west1-b"
}

variable "osd_instance_count" {
  type    = number
  default = 2
}

variable "gcp_default_machine_type" {
  type    = string
  default = "e2-medium"
}

variable "gcp_default_machine_image"{
  type    = string
  default = "debian-cloud/debian-11"
}