resource "kubectl_manifest" "image-automations" {
  for_each = var.image_update_automations

  yaml_body = <<YAML
apiVersion: image.toolkit.fluxcd.io/v1beta1
kind: ImageUpdateAutomation
metadata:
  name: ${each.key}
  namespace: ${var.target_namespace}
spec:
  interval: 30s
  sourceRef:
    kind: GitRepository
    name: repo
  git:
    checkout:
      ref:
        branch: master
    commit:
      author:
        email: ml3k@interia.pl
        name: fluxcd
      messageTemplate: |
        (FluxCD) Update images
        {{ range .Updated.Images}}
        - {{ . }}
        {{ end }}
    push:
      branch: master
  update:
    path: ${var.repo.patchPath}
    strategy: Setters
YAML

  depends_on = [kubectl_manifest.image-policies]

}
