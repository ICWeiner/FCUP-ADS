# outputs - Backup

output  "backup_reserved_external_ip" {
	value = google_compute_address.backup_reserved_external_ip.address
}

output  "backup_reserved_internal_ip" {
	value = google_compute_address.backup_reserved_internal_ip.address
}