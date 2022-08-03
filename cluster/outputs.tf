output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_endpoint" {
  value       = module.gke_cluster.cluster_endpoint
  description = "GKE Cluster Host"
}

output "load_balancer_ip" {
  value       = module.k8s_infra.load_balancer_ip
  description = "GKE Cluster Host"
}
