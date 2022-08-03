resource "kubernetes_secret" "repo-creds" {
  metadata {
    name = "repo-creds"
    namespace = var.target_namespace
  }

  data = {
    username = var.repo.username
    password = var.repo.password
  }

  type = "Opaque"

}

resource "kubernetes_secret" "chartrepo-creds" {
  metadata {
    name = "chartrepo-creds"
    namespace = var.target_namespace
  }

  data = {
    username = var.chartrepo.username
    password = var.chartrepo.password
  }

  type = "Opaque"

}

resource "kubernetes_secret" "registry-creds" {
  metadata {
    name = "registry-creds"
    namespace = var.target_namespace
  }

data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry.hostname}" = {
          "auth"     = base64encode("${var.registry.username}:${var.registry.password}")
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"

}

resource "kubernetes_secret" "webhook-token" {
  metadata {
    name = "webhook-token"
    namespace = var.target_namespace
  }

  data = {
    token = var.webhook_token
  }

  type = "Opaque"
}


