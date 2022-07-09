terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~>2.11.3"

    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "api_key" {
  type    = string
  default = "C27SXVLNXLT7RVS52SMMDBNAGKAVDDBJNWMQ"
}

# Configure the DigitalOcean Provider
provider "vultr" {
  api_key     = var.api_key
  rate_limit  = 700
  retry_limit = 3
}