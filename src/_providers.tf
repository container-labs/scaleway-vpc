terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.4.0"
    }
  }
}

locals {
  # region_to_zones = {
  #   "fr-par" = ["fr-par-1", "fr-par-2", "fr-par-3"]
  #   "nl-ams" = ["nl-ams-1", "nl-ams-2"]
  #   "pl-waw" = ["pl-waw-1"]
  # }
  private_region_to_zones = {
    "fr-par" = ["fr-par-1"]
    "nl-ams" = ["nl-ams-1"]
    "pl-waw" = ["pl-waw-1"]
  }
  zone = local.private_region_to_zones[var.region][0]
}

provider "scaleway" {
  access_key = var.scw_authentication.data.access_key
  secret_key = var.scw_authentication.data.secret_key
  project_id = var.scw_authentication.data.project_id
  region     = var.region
  zone       = local.zone
}
