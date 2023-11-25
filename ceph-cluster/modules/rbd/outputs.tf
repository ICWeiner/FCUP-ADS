# outputs - RBD

output  "rbd_reserved_external_ip" {
	value = google_compute_address.rbd_reserved_external_ip.address
}

output  "rbd_reserved_internal_ip" {
	value = google_compute_address.rbd_reserved_internal_ip.address
}