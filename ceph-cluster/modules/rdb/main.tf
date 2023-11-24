# main.tf - RDB

resource "google_compute_instance" "rbd_client_instance" {
  name         = "ceph-rbd-client"
  machine_type = var.gcp_default_machine_type
  zone         = var.gcp_region

  boot_disk {
                initialize_params {
                        image = var.gcp_default_machine_image
                }
        }

        network_interface {
                network = "default"
        }

}