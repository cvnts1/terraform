resource "kubernetes_namespace_v1" "flux" {
  metadata {
    name = "flux-system"
  }
}

data "http" "flux-manifests" {
  url = "https://github.com/fluxcd/flux2/releases/download/${var.flux_version}/install.yaml"
}

data "kubectl_file_documents" "apply" {
  content = data.http.flux-manifests.body
}

# Convert documents list to include parsed yaml data
locals {
  apply = [ for v in data.kubectl_file_documents.apply.documents : {
      data: yamldecode(v)
      content: v
    }
  ]
}

# Apply manifests on the cluster
resource "kubectl_manifest" "flux" {
  for_each   = { for v in local.apply : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [
    kubernetes_namespace_v1.flux
  ]
  yaml_body = each.value
}
