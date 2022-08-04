resource "kubectl_manifest" "image-repositories" {
  for_each = var.image_update_automations

  yaml_body = <<YAML
apiVersion: image.toolkit.fluxcd.io/v1beta1
kind: ImageRepository
metadata:
  name: ${each.key}
  namespace: ${var.target_namespace}
spec:
  interval: 24h
  image: ${each.value}
YAML

  wait = true
}
