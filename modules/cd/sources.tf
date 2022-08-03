resource "kubectl_manifest" "git-repository" {
  yaml_body = <<YAML
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: repo
  namespace: ${var.target_namespace}
spec:
  gitImplementation: go-git
  interval: 24h
  secretRef:
    name: repo-creds
  timeout: 20s
  url: ${var.repo.url}
YAML

  wait = true
  depends_on = [kubernetes_secret.repo-creds]

}

resource "kubectl_manifest" "helm-repository" {
  yaml_body = <<YAML
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: chartrepo
  namespace: ${var.target_namespace}
spec:
  interval: 5m0s
  secretRef:
    name: chartrepo-creds
  timeout: 1m0s
  url: ${var.chartrepo.url}
YAML

  wait = true
  depends_on = [kubernetes_secret.chartrepo-creds]

}
