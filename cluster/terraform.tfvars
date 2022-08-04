deployment_id = "cluster1"

# App
domain  = "aqws.lakis.eu" # zone should dbe set to main domain
health_message = "Health message from k8s"

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

# Webhook endpoint & token:
flux_webhook_address = "flux944.lakis.eu"
flux_webhook_token   = "duck"

# CD configuration
image_update_automations = {
  server = "harbor.lakis.eu/cvnts1/server"
}
chartrepo = "https://harbor.lakis.eu/chartrepo/cvnts1"

# Chart git repo data for delivering patches to git. deployment key needs to be r/w
chart_git_url = "ssh://github.com/cvnts1/charts.git"
#chart_git_dep_key = 

# Versions of infrastructure services
flux_version         = "v0.31.5"
cert_manager_version = "v1.9.1"
traefik_version      = "10.24.0"
