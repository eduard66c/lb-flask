resource "google_container_cluster" "autopilot_cluster" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  deletion_protection = false

  ip_allocation_policy {}
}
