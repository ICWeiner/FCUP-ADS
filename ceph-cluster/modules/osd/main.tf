# main.tf - OSD


resource "google_compute_address" "osd_reserved_external_ip" {
  count  = var.osd_instance_count
  name   = "osd-reserved-external-ip-${count.index}"
  region = var.gcp_region_network
}

resource "google_compute_address" "osd_reserved_internal_ip" {
  count        = var.osd_instance_count
  name         = "osd-reserved-internal-ip-${count.index}"
  region       = var.gcp_region_network
  address_type = "INTERNAL"
}

resource "google_compute_disk" "osd_data_disk" {
  count = var.osd_instance_count
  name  = "ceph-osd-data-disk-${count.index}"
  size  = var.osd_data_disk_size_gb
  type  = var.gcp_data_disk_type
  zone  = var.gcp_region
}


resource "google_compute_instance" "osd_instance" {
  count        = var.osd_instance_count
  name         = "ceph-osd-${count.index}"
  machine_type = var.gcp_default_machine_type
  zone         = var.gcp_region

  metadata_startup_script = file("${path.module}/cloud-init.sh")

  tags = ["ceph-nodes"]

	boot_disk {
                initialize_params {
                        image = var.gcp_default_machine_image
                }
        }

  attached_disk {
    source = google_compute_disk.osd_data_disk[count.index].self_link
  }

        network_interface {
                network = "default"

                access_config {
                      nat_ip = google_compute_address.osd_reserved_external_ip[count.index].address
                    }

                    network_ip = google_compute_address.osd_reserved_internal_ip[count.index].address
        }
        
}
