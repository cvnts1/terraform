data "cloudflare_zone" "zone" {
  name = "${var.cloudflare_zone}"
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.zone.id
  name = "${var.domain}"
  value = "${var.ip}"
  type = "A"
  ttl = 3600
  proxied = false
}
