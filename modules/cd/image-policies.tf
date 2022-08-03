resource "kubectl_manifest" "image-policies" {
  for_each = var.image_update_automations

  yaml_body = <<YAML
apiVersion: image.toolkit.fluxcd.io/v1beta1
kind: ImagePolicy
metadata:
  name: ${each.key}
  namespace: ${var.target_namespace}
spec:
  imageRepositoryRef:
    name: ${each.key}
  policy:
    semver:
      range: '>=0.0.0'
YAML

  depends_on = [kubectl_manifest.image-repositories]
}
