# main.tf - MGR

resource "google_compute_instance" "mgr_instance" {
  name         = "ceph-mgr"
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