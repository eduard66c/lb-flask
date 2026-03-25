output "service_account_email" {
  value = google_service_account.github_actions_sa.email
}

output "pool_id" {
  value = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
}

output "provider_id" {
  value = google_iam_workload_identity_pool_provider.github_provider.workload_identity_pool_provider_id
}

output "provider_name" {
  value = google_iam_workload_identity_pool_provider.github_provider.name
}
