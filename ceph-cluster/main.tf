# main.tf

provider "google" {
  credentials = file(var.gcp_credentials_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}

resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_subnetwork" {
  name                     = "my-subnetwork"
  region                   = var.gcp_region_network
  network                  = google_compute_network.my_vpc.self_link
  ip_cidr_range            = "10.0.1.0/24" 
  private_ip_google_access = true
}

resource "google_compute_firewall" "ceph_cluster" {
  name    = "ceph-cluster-firewall"
  network = google_compute_network.my_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["3300"]  # Adjust ports as needed for Ceph
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust as needed for your network security

  target_tags = ["ceph-nodes"]  # Apply this firewall rule to instances with this tag
}


# OSD Instances
module "osd" {
  source               = "./modules/osd"

  osd_instance_count = var.osd_instance_count
  osd_data_disk_size_gb = var.osd_data_disk_size_gb

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


data "template_file" "cephadm_config" {
  template = file("${path.module}/cephadm-config.yaml.tpl")

  vars = {
    osd_instance_count  = var.osd_instance_count
    osd_host_1          = module.osd.osd_reserved_external_ips[0]
    osd_host_2          = module.osd.osd_reserved_external_ips[1]

    mon_host = module.mon.mon_reserved_external_ip

    mgr_host = module.mgr.mgr_reserved_external_ip

    rbd_host = module.rbd.rbd_reserved_external_ip

  }
}

resource "local_file" "cephadm_config_file" {
  content  = data.template_file.cephadm_config.rendered
  filename = "cephadm-config.yaml"
}
