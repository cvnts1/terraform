# To GKE
variable "deployment_id" { }
variable "num_nodes" { }
variable "node_type" { }
variable "gke_zone" { }
variable "gke_region" { }

# To CF, passed via env var
variable "cloudflare_email" { }
variable "cloudflare_api_key" { }
variable "cloudflare_zone" { }

variable "cert_email" { }

variable "flux_version" { }

# App data
variable "app_domain" { }
variable "cert_email" { default = "mlody3k@gmail.com" }
variable "chart_version" { default = "0.1.4" }
variable "chartmuseum" { }

