resource "kubernetes_secret" "repo-creds" {
  metadata {
    name = "chart-repo-dep-key"
    namespace = var.target_namespace
  }

  data = {
    identity = var.chart_git_dep_key
    known_hosts = var.chart_git_known_hosts
  }

  type = "Opaque"

}

resource "kubernetes_secret" "webhook-token" {
  metadata {
    name = "webhook-token"
    namespace = var.target_namespace
  }

  data = {
    token = var.flux_webhook_token
  }

  type = "Opaque"
}