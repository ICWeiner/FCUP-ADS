# main.tf - MON

resource "google_compute_address" "mon_reserved_external_ip" {
  name = "mon-reserved-external-ip"
  region = var.gcp_region_network
}

resource "google_compute_address" "mon_reserved_internal_ip" {
  name   = "mon-reserved-internal-ip" 
  region = var.gcp_region_network
  address_type = "INTERNAL"
}

resource "google_compute_instance" "mon_instance" {
  name        = "ceph-mon"
  machine_type = var.gcp_default_machine_type
  zone         = var.gcp_region

  metadata_startup_script = file("${path.module}/cloud-init.sh")

  tags = ["ceph-nodes","ceph-dashboard"]

  boot_disk {
                initialize_params {
                        image = var.gcp_default_machine_image
                }
        }

        network_interface {
                network = "default"

                access_config {
                        nat_ip = google_compute_address.mon_reserved_external_ip.address
                }
                
                network_ip = google_compute_address.mon_reserved_internal_ip.address
        }

}
