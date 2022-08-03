resource "google_container_cluster" "cluster" {
  name     = "${var.deployment_id}"
  location = "${var.gke_zone}"
  
  initial_node_count = var.num_nodes

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  node_config {
    preemptible  = true
    machine_type = var.node_type
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  ip_allocation_policy { }

  min_master_version = "1.23.7-gke.1400"
}
