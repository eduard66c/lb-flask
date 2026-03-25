output "repository_id" {
  value = google_artifact_registry_repository.primary_repo.repository_id
}

output "repository_url" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.primary_repo.repository_id}"
}

output "cache_url" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/docker-hub-cache"
}

output "location" {
  value = google_artifact_registry_repository.primary_repo.location
}
