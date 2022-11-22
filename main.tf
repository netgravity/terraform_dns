terraform {
  backend "s3" {
   # bucket = "${var.aws_s3_backend_bucket}"
    bucket = "sunny-tf"
    key    = "terraform/dev/terraform.tfstate"
    #region = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}



data "cloudflare_zone" "this" {
   name = "${var.clflare_dns}"
}

locals {
  dns_settings = {
    "ns1"  = { ns_value = tolist(aws_route53_zone.dev.name_servers)[0]},
    "ns2"  = { ns_value = tolist(aws_route53_zone.dev.name_servers)[1]},
    "ns3"  = { ns_value = tolist(aws_route53_zone.dev.name_servers)[2]},
    "ns4"  = { ns_value = tolist(aws_route53_zone.dev.name_servers)[3]}
  }
}

resource "cloudflare_record" "ns_records" {
  for_each = local.dns_settings
  name     = "${var.clflare_sub}"
  zone_id  = data.cloudflare_zone.this.id
  value    = each.value.ns_value
  type     = "NS"
  proxied  = false
}
