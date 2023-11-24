# main.tf - MON

resource "google_compute_instance" "mon_instance" {
  name        = "ceph-mon"
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
