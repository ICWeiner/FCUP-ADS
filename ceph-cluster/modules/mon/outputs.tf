# outputs - MON

output  "mon_reserved_external_ip" {
	value = google_compute_address.mon_reserved_external_ip.address
}

output  "mon_reserved_internal_ip" {
	value = google_compute_address.mon_reserved_internal_ip.address
}