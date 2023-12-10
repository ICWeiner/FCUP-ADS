# main.tf - Backup

resource "google_compute_address" "backup_reserved_external_ip" {
  name = "backup-reserved-external-ip"
  region = var.gcp_region_network
}

resource "google_compute_address" "backup_reserved_internal_ip" {
  name   = "backup-reserved-internal-ip" 
  region = var.gcp_region_network
  address_type = "INTERNAL"
}


resource "google_compute_instance" "backup_instance" {
  name         = "ceph-backup-server"
  machine_type = var.gcp_default_machine_type
  zone         = var.gcp_region

  boot_disk {
                initialize_params {
                        image = var.gcp_default_machine_image
                }
        }

        network_interface {
                network = "default"

                access_config {
                        nat_ip = google_compute_address.backup_reserved_external_ip.address
                }
                
                network_ip = google_compute_address.backup_reserved_internal_ip.address
        }

}