module "identity" {
  source      = "./modules/identity"
  project_id  = var.project_id
  github_repo = var.github_repo
}

module "registry" {
  source     = "./modules/registry"
  project_id = var.project_id
  region     = var.region
}

module "gke" {
  source     = "./modules/gke"
  project_id = var.project_id
  region     = var.region
}

resource "helm_release" "fastapi_app" {
  name       = "fastapi-release"
  repository = "oci://${module.registry.repository_url}"
  chart      = "my-fastapi-chart"
  version    = "0.1.0"
  namespace  = "default"

  set {
    name  = "image.repository"
    value = "${module.registry.repository_url}/flask-app"
  }

  depends_on = [module.gke]
}
