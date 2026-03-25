output "cluster_name" {
  value = google_container_cluster.autopilot_cluster.name
}

output "cluster_location" {
  value = google_container_cluster.autopilot_cluster.location
}

output "cluster_endpoint" {
  value = google_container_cluster.autopilot_cluster.endpoint
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.autopilot_cluster.master_auth[0].cluster_ca_certificate
  sensitive = true
}
