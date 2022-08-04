variable "cloudflare_email" { }
variable "cloudflare_api_key" { }
variable "cert_email" { default = "mlody3k@gmail.com" }

variable "flux_webhook_address" { }

variable "flux_version" { default = "v0.31.5" }
variable "cert_manager_version" { default = "v1.9.1" }
variable "traefik_version" { default = "10.24.0" }