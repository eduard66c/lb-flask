resource "google_artifact_registry_repository" "primary_repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker images and Helm charts for Flask app"
  format        = "DOCKER"

  cleanup_policies {
    id     = "delete-old-images"
    action = "DELETE"
    condition {
      older_than = "2592000s" # 30 days
    }
  }
}

resource "google_artifact_registry_repository" "docker_hub_cache" {
  location      = var.region
  repository_id = "docker-hub-cache"
  description   = "Remote proxy for Docker Hub"
  format        = "DOCKER"
  mode          = "REMOTE_REPOSITORY"

  remote_repository_config {
    description = "Docker Hub proxy"
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }
}
