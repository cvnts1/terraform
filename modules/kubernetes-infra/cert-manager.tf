resource "kubernetes_namespace_v1" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"
  namespace = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  set {
    name = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace_v1.cert-manager
  ]
}

resource "kubernetes_secret" "cloudflare-api-key" {
  metadata {
    name = "cloudflare-api-key"
    namespace = "cert-manager"
  }
  data = {
    apikey = "${var.cloudflare_api_key}"
  }

depends_on = [
    kubernetes_namespace_v1.cert-manager
  ]

}

resource "kubectl_manifest" "clusterissuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: le-default
spec:
  acme:
    email: ${var.cert_email}
    privateKeySecretRef:
      name: le-default-account-key
    #server: https://acme-staging-v02.api.letsencrypt.org/directory
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
    - dns01:
        cloudflare:
          apiKeySecretRef:
            key: apikey
            name: cloudflare-api-key
          email: ${var.cloudflare_email}
YAML
  depends_on = [
    kubernetes_secret.cloudflare-api-key,
    helm_release.cert-manager
  ]

}
