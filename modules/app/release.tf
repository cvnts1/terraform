resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubectl_manifest" "app" {
  yaml_body = <<YAML
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: app
  namespace: ${var.namespace_name}
spec:
  chart:
    spec:
      chart: cvnts1
      interval: 1m0s
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: chartrepo
        namespace: flux-system
      version: '>=0.1.0'
  interval: 5m0s
  test:
    enable: true
  upgrade:
    remediation:
      remediateLastFailure: true
  values:
    server:
      health_message: ${var.health_message}
    ingress:
      domain: ${var.domain}
YAML

  depends_on=[kubernetes_namespace_v1.app]

}