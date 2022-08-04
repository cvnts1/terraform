module gke_cluster {
  source = "./../modules/gke"

  deployment_id = var.deployment_id
  num_nodes = var.num_nodes
  node_type = var.node_type
  gke_zone = var.gke_zone
  gke_region = var.gke_region
}

module k8s_infra {
  source = "./../modules/kubernetes-infra"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  cert_email = var.cert_email

  flux_webhook_address = var.flux_webhook_address

  flux_version = var.flux_version
  cert_manager_version = var.cert_manager_version
  traefik_version = var.traefik_version

}

module dns {
  source = "./../modules/dns"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  cloudflare_zone = var.cloudflare_zone

  domain = var.domain
  ip = module.k8s_infra.load_balancer_ip
}

module dns-flux {
  source = "./../modules/dns"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  cloudflare_zone = var.cloudflare_zone

  domain = var.flux_webhook_address
  ip = module.k8s_infra.load_balancer_ip
}


module cd {
  source = "./../modules/cd"

  flux_webhook_token   = var.flux_webhook_token
  image_update_automations = var.image_update_automations
  chartrepo = var.chartrepo
  chart_git_url = var.chart_git_url
  chart_git_dep_key = var.chart_git_dep_key

  depends_on = [module.k8s_infra]
}

module app {
  source = "./../modules/app"

  health_message = var.health_message
  domain = var.domain

  depends_on = [module.cd]
}
