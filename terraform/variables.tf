variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The GCP region for all resources"
}

variable "github_repo" {
  type        = string
  description = "Format: username/repository-name"
}
