# outputs - OSD

output "osd_reserved_external_ips" {
  value = google_compute_address.osd_reserved_external_ip[*].address
}

output "osd_reserved_internal_ips" {
  value = google_compute_address.osd_reserved_internal_ip[*].address
}