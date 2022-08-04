resource "kubernetes_namespace_v1" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  name = "traefik"
  namespace = "traefik"
  repository = "https://helm.traefik.io/traefik"
  chart = "traefik"
  set {
    name = "service.enabled"
    value = false
  }

  set {
    name = "ports.web.redirectTo"
    value = "websecure"
  }

  depends_on = [
    kubernetes_namespace_v1.traefik
  ]
}

resource "kubernetes_service" "traefik" {
  metadata {
    name = "traefik-lb"
    namespace = "traefik"
  }
  spec {
    selector = {
      "app.kubernetes.io/instance" =  "traefik"
      "app.kubernetes.io/name" = "traefik"
    }

  port {
      name        = "http"
      port        = 80
      target_port = 8000
    }

    port {
      name = "https"
      port = 443
      target_port = 8443
    }

    type = "LoadBalancer"
  }

  depends_on = [
    kubernetes_namespace_v1.traefik
  ]

}
