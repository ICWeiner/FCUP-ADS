# outputs - MGR

output  "mgr_reserved_external_ip" {
	value = google_compute_address.mgr_reserved_external_ip.address
}

output  "mgr_reserved_internal_ip" {
	value = google_compute_address.mgr_reserved_internal_ip.address
}