terraform {
  backend "gcs" {
    bucket = "lb-flaskapp-poc-tfstate"
    prefix = "terraform/state"
  }
  required_providers {
    google = { source = "hashicorp/google", version = "~> 6.0" }
    helm   = { source = "hashicorp/helm", version = "~> 2.0" }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}
