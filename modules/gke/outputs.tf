output "cluster_endpoint" {
  value       = google_container_cluster.cluster.endpoint
  description = "GKE Cluster Host"
}

output "cluster_ca" {
  value       = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
  description = "GKE Cluster Name"
}

