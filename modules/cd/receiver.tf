
resource "kubectl_manifest" "receiver" {

  yaml_body = templatefile("${path.module}/receiver.tftpl", { image_update_automations = var.image_update_automations, namespace = var.target_namespace })

  depends_on = [kubectl_manifest.image-policies]

}
