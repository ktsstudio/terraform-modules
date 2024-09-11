# provider "cloudflare" {}

resource "cloudflare_zone" "zone" {
  account_id = var.account_id
  zone       = var.zone
}

resource "cloudflare_record" "A_record" {
  for_each = var.A
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "A"
  ttl      = each.value.ttl
  proxied  = each.value.proxied
  content  = each.value.value
}

resource "cloudflare_record" "AAAA_record" {
  for_each = var.AAAA
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "AAAA"
  ttl      = each.value.ttl
  proxied  = each.value.proxied
  content  = each.value.value
}

resource "cloudflare_record" "CNAME_record" {
  for_each = var.CNAME
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "CNAME"
  ttl      = each.value.ttl
  proxied  = each.value.proxied
  content  = each.value.value
}

resource "cloudflare_record" "TXT_record" {
  for_each = var.TXT
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "TXT"
  ttl      = each.value.ttl
  content  = each.value.value
}

resource "cloudflare_record" "MX_record" {
  for_each = var.MX
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "MX"
  ttl      = each.value.ttl
  content  = each.value.value
  priority = each.value.priority

  lifecycle {
    ignore_changes = [
      data,
    ]
  }
}

resource "cloudflare_record" "NS_record" {
  for_each = var.NS
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = "NS"
  ttl      = each.value.ttl
  content  = each.value.value
}
