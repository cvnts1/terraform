# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.deployment_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.deployment_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# Egress route
resource "google_compute_route" "egress_internet" {
  name             = "${var.deployment_id}-egress"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc.name
  next_hop_gateway = "default-internet-gateway"
}

# Router
resource "google_compute_router" "router" {
  name    = "${var.deployment_id}-router"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc.name
}

# NAT
resource "google_compute_router_nat" "nat_router" {
  name                               = "${google_compute_subnetwork.subnet.name}-nat-router"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


# https://thoeny.dev/create-a-private-gcp-kubernetes-cluster-using-terraform
