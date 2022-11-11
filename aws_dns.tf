provider "aws" {
#  profile = "default"
  region  = "${var.aws_region}"
}



resource "aws_route53_zone" "dev" {
  #name = "${var.aws_dns_name}"
  name = var.aws_dns_name

  tags = {
    env = "dev"
    Terraform = "true"
  }
}

output "aws_nameservers" {
  value = "${aws_route53_zone.dev.name_servers}"
}

