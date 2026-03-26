resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.actor"      = "assertion.actor"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_condition = "assertion.repository == \"${var.github_repo}\""
}

resource "google_service_account" "github_actions_sa" {
  account_id   = "github-actions-deployer"
  display_name = "Service Account for GitHub Actions"
}

resource "google_service_account_iam_member" "wif_binding" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_repo}"
}

# Project-level IAM roles for the deployer SA
locals {
  deployer_roles = [
    "roles/storage.admin",           # Read/write Terraform GCS backend
    "roles/container.admin",         # Create & manage GKE clusters
    "roles/artifactregistry.admin",  # Push Docker images & Helm charts
    "roles/iam.serviceAccountUser",  # Impersonate SAs (needed by GKE node pool)
    "roles/iam.serviceAccountAdmin", # Manage service accounts via Terraform
    "roles/compute.viewer",          # Read instance groups backing GKE node pools
  ]
}

resource "google_project_iam_member" "deployer_roles" {
  for_each = toset(local.deployer_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.github_actions_sa.email}"
}
