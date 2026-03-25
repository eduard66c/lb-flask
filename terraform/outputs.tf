
output "gh_actions_wif_provider" {
  value = module.identity.provider_name
}

output "gh_actions_service_account" {
  value = module.identity.service_account_email
}

output "gke_cluster_endpoint" {
  value = module.gke.cluster_endpoint
}
