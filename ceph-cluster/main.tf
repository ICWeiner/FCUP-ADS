# main.tf

provider "google" {
  credentials = file(var.gcp_credentials_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}

# OSD Instances
module "osd" {
  source               = "./modules/osd"
  osd_instance_count = var.osd_instance_count
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_default_machine_image = var.gcp_default_machine_image
}


# MON Instance
module "mon" {
  source               = "./modules/mon"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_default_machine_image = var.gcp_default_machine_image
}


# MGR Instance
module "mgr" {
  source               = "./modules/mgr"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_default_machine_image = var.gcp_default_machine_image
}

# RBD Instance
module "rbd" {
  source               = "./modules/rdb"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_default_machine_image = var.gcp_default_machine_image
}


# Backup Server Instance
module "backup" {
  source               = "./modules/backup"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_default_machine_image = var.gcp_default_machine_image
}
