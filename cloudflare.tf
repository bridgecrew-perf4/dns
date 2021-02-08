terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare" # https://github.com/cloudflare/terraform-provider-cloudflare
    }
  }
}

provider "cloudflare" {
  api_key = var.api_key
  email   = var.email
}

variable "api_key" {
  type = string
}

variable "email" {
  type = string
}

variable "zone_id" {
  type = string
}

resource "cloudflare_record" "web-a" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "A"
  value   = "192.0.2.1" # Dummy value, overriden by page rule
  proxied = true
}

resource "cloudflare_page_rule" "web-redirect-rule" {
  zone_id = var.zone_id
  target  = "*treebeard.io/slack"
  actions {
    forwarding_url {
      status_code = 301
      url         = "https://join.slack.com/t/treebeard-entmoot/shared_invite/zt-ltyrvvmv-g7Rl1vi3QaDhGiDmXOCNfg"
    }
  }
}

resource "cloudflare_page_rule" "web-redirect-rule" {
  zone_id = var.zone_id
  target  = "*treebeard.io/*"
  actions {
    forwarding_url {
      status_code = 301
      url         = "https://github.com/alex-treebeard"
    }
  }
}

resource "cloudflare_record" "api-cname" {
  zone_id = var.zone_id
  name    = "api.treebeard.io"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
}

resource "cloudflare_record" "firebase-dkim" {
  zone_id = var.zone_id
  name    = "firebase1._domainkey.treebeard.io"
  type    = "CNAME"
  value   = "mail-treebeard-io.dkim1._domainkey.firebasemail.com"
}

resource "cloudflare_record" "firebase-dkim-2" {
  zone_id = var.zone_id
  name    = "firebase2._domainkey.treebeard.io"
  type    = "CNAME"
  value   = "mail-treebeard-io.dkim2._domainkey.firebasemail.com"
}

resource "cloudflare_record" "gmtrack" {
  zone_id = var.zone_id
  name    = "mail.treebeard.io"
  type    = "CNAME"
  value   = "x.gmtrack.net"
}

resource "cloudflare_record" "mx" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "MX"
  value   = "aspmx.l.google.com"
}

resource "cloudflare_record" "mx-alt" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "MX"
  value   = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "acme" {
  zone_id = var.zone_id
  name    = "_acme-challenge.treebeard.io"
  type    = "TXT"
  value   = "n7VIQFpFzMVTwZlLq4Jhjt9fj59T3JqSFR5jfu5W_Q0"
}

resource "cloudflare_record" "ses" {
  zone_id = var.zone_id
  name    = "_amazonses.treebeard.io"
  type    = "TXT"
  value   = "lduinK9QIat5YoSUmeEA2fqWJPfeNHI9cePKvNpmh8w="
}

resource "cloudflare_record" "google-site-verification" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "TXT"
  value   = "google-site-verification=St8a2u1QUAxY71U1ppo7Cw5lhhTp7VKs7pnzqP9_UdQ"
}

resource "cloudflare_record" "firebase-project" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "TXT"
  value   = "firebase=treebeard-259315"
}

resource "cloudflare_record" "firebase-spf" {
  zone_id = var.zone_id
  name    = "treebeard.io"
  type    = "TXT"
  value   = "v=spf1 include:_spf.firebasemail.com ~all"
}

