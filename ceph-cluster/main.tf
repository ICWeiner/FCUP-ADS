# main.tf

provider "google" {
  credentials = file(var.gcp_credentials_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}

resource "google_compute_firewall" "ceph_cluster" {
  name    = "ceph-cluster-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3300"]  # Adjust ports as needed for Ceph
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust as needed for your network security

  target_tags = ["ceph-nodes"]  # Apply this firewall rule to instances with this tag
}

resource "google_compute_firewall" "ceph_dashboard" {
  name    = "ceph-cashboard-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8443"]  # Adjust ports as needed for Ceph
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust as needed for your network security

  target_tags = ["ceph-dashboard"]  # Apply this firewall rule to instances with this tag
}

resource "google_compute_firewall" "postgres" {
  name    = "postgres-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["5432"]  # Adjust ports as needed for Ceph
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust as needed for your network security

  target_tags = ["postgres"]  # Apply this firewall rule to instances with this tag
}


# OSD Instances
module "osd" {
  source               = "./modules/osd"

  osd_instance_count = var.osd_instance_count
  osd_data_disk_size_gb = var.osd_data_disk_size_gb
  gcp_data_disk_type = var.gcp_data_disk_type

  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_region_network = var.gcp_region_network
  gcp_default_machine_image = var.gcp_default_machine_image
}

output "osd_reserved_external_ips" {
  value = module.osd.osd_reserved_external_ips
}

output "osd_reserved_internal_ips" {
  value = module.osd.osd_reserved_internal_ips
}

# MON Instance
module "mon" {
  source               = "./modules/mon"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_region_network = var.gcp_region_network
  gcp_default_machine_image = var.gcp_default_machine_image
}

output "mon_reserved_external_ip" {
  value = module.mon.mon_reserved_external_ip
}

output "mon_reserved_internal_ip" {
  value = module.mon.mon_reserved_internal_ip
}



# MGR Instance
module "mgr" {
  source               = "./modules/mgr"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_region_network = var.gcp_region_network
  gcp_default_machine_image = var.gcp_default_machine_image
}

output "mgr_reserved_external_ip" {
  value = module.mgr.mgr_reserved_external_ip
}

output "mgr_reserved_internal_ip" {
  value = module.mgr.mgr_reserved_internal_ip
}



# RBD Instance
module "rbd" {
  source               = "./modules/rbd"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_region_network = var.gcp_region_network
  gcp_default_machine_image = var.gcp_default_machine_image
}

output "rbd_reserved_external_ip" {
  value = module.rbd.rbd_reserved_external_ip
}

output "rbd_reserved_internal_ip" {
  value = module.rbd.rbd_reserved_internal_ip
}



# Backup Server Instance
module "backup" {
  source               = "./modules/backup"
  gcp_default_machine_type = var.gcp_default_machine_type
  gcp_region = var.gcp_region
  gcp_region_network = var.gcp_region_network
  gcp_default_machine_image = var.gcp_default_machine_image
}

output "backup_reserved_external_ip" {
  value = module.backup.backup_reserved_external_ip
}

output "backup_reserved_internal_ip" {
  value = module.backup.backup_reserved_internal_ip
}