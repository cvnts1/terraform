terraform {
    required_providers {
        kubectl = {
            source  = "gavinbunney/kubectl"
            version = ">= 1.7.0"
        }
        cloudflare = {
            source = "cloudflare/cloudflare"
            version = "~> 3.0"
        }
    }
}

data "google_client_config" "provider" {} # Local client config

provider "google" {
  project = var.gke_project_id
  region  = var.gke_region
}

provider "helm" {
  kubernetes {
    host  = "https://${module.gke_cluster.cluster_endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca)
  }
}

provider "kubectl" {
  host  = "https://${module.gke_cluster.cluster_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca)
}

provider "kubernetes" {
  host  = "https://${module.gke_cluster.cluster_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca)
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

