module gke_cluster {
  source = "./../../modules/gke"

  deployment_id = var.deployment_id
  num_nodes = var.num_nodes
  node_type = var.node_type
  gke_zone = var.gke_zone
  gke_region = var.gke_region
}

module k8s_infra {
  source = "./../../modules/kubernetes-infra"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  cert_email = var.cert_email
  flux_version = var.flux_version
  cert_manager_version = var.cert_manager_version
  traefik_version = var.traefik_version
}

module dns {
  source = "./../../modules/dns"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  cloudflare_zone = var.cloudflare_zone

  domain = var.domain
  ip = module.k8s_infra.load_balancer_ip
}

module cd {
  source = "./../../modules/flux-control-plane"
}

#module app {
#  source = "./../../modules/app"
#  namespace_name = "live"
#  release_name = "live"
#}