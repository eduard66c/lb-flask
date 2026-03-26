variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Region to deploy GKE"
}

variable "cluster_name" {
  type        = string
  default     = "flaskapp-autopilot-cluster"
  description = "The name of your GKE Autopilot Cluster"
}
