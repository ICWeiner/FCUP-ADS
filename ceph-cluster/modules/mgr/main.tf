# main.tf - MGR


resource "google_compute_address" "mgr_reserved_external_ip" {
  name = "mgr-reserved-external-ip"
  region = var.gcp_region_network
}

resource "google_compute_address" "mgr_reserved_internal_ip" {
  name   = "mgr-reserved-internal-ip"  # You can customize the name
  region = var.gcp_region_network
  address_type = "INTERNAL"
}

resource "google_compute_instance" "mgr_instance" {
  name         = "ceph-mgr"
  machine_type = var.gcp_default_machine_type
  zone         = var.gcp_region

  metadata_startup_script = file("${path.module}/cloud-init.sh")

  tags = ["ceph-nodes"]

  boot_disk {
                initialize_params {
                        image = var.gcp_default_machine_image
                }
        }

        network_interface {
                network = "default"

                access_config {
                        nat_ip = google_compute_address.mgr_reserved_external_ip.address
                }
                
                network_ip = google_compute_address.mgr_reserved_internal_ip.address
        }

}