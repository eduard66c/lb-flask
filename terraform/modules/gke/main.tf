resource "google_container_cluster" "autopilot_cluster" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  deletion_protection = false

  ip_allocation_policy {}
}

resource "google_container_node_pool" "autopilot_nodes" {
  name       = "autopilot-pool"
  location   = var.region
  cluster    = google_container_cluster.autopilot_cluster.name
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
