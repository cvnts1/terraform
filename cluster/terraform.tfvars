deployment_id = "cluster0"
domain  = "aqws.lakis.eu" # zone should dbe set to main domain

# GKE
num_nodes      = 1
node_type      = "e2-standard-4"
gke_zone       = "europe-central2-a" # For cluster, we create zonal one to allow lower number of nodes
gke_region     = "europe-central2" # For VPC
gke_project_id = "klive-350621"

# Following variables need to be set in env vars
# Token needs to have permissions for adding DNS entries in zone
#cloudflare_email   = "..."
#cloudflare_api_key = "..."
#cloudflare_zone    = "..."

# E-mail for requesting certificate from LE
cert_email       = "mlody3k@gmail.com"

# Versions of infrastructure services
flux_version         = "v0.31.5"
cert_manager_version = "v1.9.1"
traefik_version      = "10.24.0"