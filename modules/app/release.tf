resource "helm_release" "live" {
  name = "live"
  namespace = var.namespace_name
  repository = var.chartmuseum
  chart = "3klive"
  version = var.chart_version

  set {
    name = "nameOverride"
    value = var.release_name
  }

  set {
    name = "global.lb_ip"
    value = var.lb_ip
  }

  set {
    name = "global.domain"
    value = var.app_domain
  }

}


