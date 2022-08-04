resource "kubectl_manifest" "git-repository" {
  yaml_body = <<YAML
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: chart
  namespace: ${var.target_namespace}
spec:
  gitImplementation: go-git
  interval: 24h
  secretRef:
    name: chart-repo-dep-key
  timeout: 20s
  url: ${var.chart_git_url}
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
  timeout: 1m0s
  url: ${var.chartrepo}
YAML

  wait = true
}
