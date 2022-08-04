# Additional service & ingress for notification controller

resource "kubectl_manifest" "certificate" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: notification-controller
  namespace: flux-system
spec:
  dnsNames:
  - "${var.flux_webhook_address}"
  duration: 2160h0m0s
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: le-default
  privateKey:
    algorithm: RSA
    encoding: PKCS1
    size: 2048          
  renewBefore: 720h0m0s
  secretName: notification-controller-cert
  subject:
    organizations:
    - LAKIS
  usages:
  - server auth
  - client auth
YAML

depends_on = [helm_release.cert-manager, kubectl_manifest.flux]
}

resource "kubernetes_service" "notifications" {
  metadata {
    name = "notification-controller-webhook"
    namespace = "flux-system"
  }
  spec {
    selector = {
      app = "notification-controller"
    }

   port {
     port = 80
     target_port = "http-webhook"
   }

   type = "ClusterIP"

  }

}

resource "kubernetes_ingress_v1" "notifications" {
  metadata {
    name = "notification-controller-webhook"
    namespace = "flux-system"
    annotations = {
      "traefik.ingress.kubernetes.io/router.tls" = true
    }
  }
  spec {
    rule {
      host = var.flux_webhook_address
      http {
        path {
          backend {
            service {
              name = "notification-controller-webhook"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "notification-controller-cert"
    }
  }

}
