variable "deployment_id" { }
variable "domain" { } 

# GKE
variable "num_nodes" { }
variable "node_type" { }
variable "gke_zone" { }
variable "gke_region" { }
variable "gke_project_id" { }

# CF. Used for ClusterIssuer & DNS provider.
variable "cloudflare_email" { }
variable "cloudflare_api_key" { }
variable "cloudflare_zone" { }

# For requesting certificates in LE
variable "cert_email" { }

# CD webhook
variable "flux_webhook_address" { }

variable "flux_version" { }
variable "cert_manager_version" { }
variable "traefik_version" { } 


