#variable "cloudflare_email" {
 # type        = string
 # description = "clouflare email address"
 # default     = "grewal.ajitpal@gmail.com"
#}

variable "clflare_api_token" {
  type        = string
  description = "cloudflare api token"
}

variable "aws_region" {}
variable "aws_dns_name" {}
variable "clflare_dns" {}
variable "clflare_sub" {}
