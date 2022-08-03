output "cluster_endpoint" {
  value       = google_container_cluster.cluster.endpoint
  description = "GKE Cluster Host"
}
