terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

data "google_client_config" "provider" {} # Local client config

provider "google" {
  project = var.project_id
  region  = var.region
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

