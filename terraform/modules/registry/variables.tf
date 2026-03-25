variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "repository_id" {
  type        = string
  default     = "flaskapp-k8s-repo"
  description = "The name of your primary Docker/Helm repo"
}
