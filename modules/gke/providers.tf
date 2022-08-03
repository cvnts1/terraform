data "google_client_config" "provider" {} # Local client config

provider "google" {
  project = var.gke_project_id
  region  = var.gke_region
}