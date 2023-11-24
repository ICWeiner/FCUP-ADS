# main.tf - OSD

# Define OSD instances
resource "google_compute_instance" "osd_instance" {
  count        = var.osd_instance_count
  name         = "ceph-osd-${count.index}"
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
