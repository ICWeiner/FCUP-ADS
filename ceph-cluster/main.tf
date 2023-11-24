# main.tf

provider "google" {
  credentials = file(var.gcp_credentials_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}

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

# MON Instance
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

# MGR Instance
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

# RBD Instance
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

# Backup Server Instance
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
        }

}

# Provision and configure Ceph on all instances
resource "null_resource" "install_ceph" {
  count = length(concat(module.osd.osd_instances, module.mon.mon_instances)) 

  provisioner "remote-exec" {
    inline = [
      "sudo wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -",
      "echo deb http://download.ceph.com/debian-{ceph-stable-release}/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list",
      "sudo apt-get update",
      "sudo apt-get install -y ceph",
    ]

    connection {
      type        = "ssh"
      user        = "your_ssh_user"
      private_key = file("path/to/your/private_key")
      host        = element(concat(module.osd.osd_ips, module.mon.mon_ips), count.index) # Choose the correct IP based on OSD or MON
    }
  }
}