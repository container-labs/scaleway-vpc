module "virtual_network" {
  source  = "container-labs/vpc/scaleway"
  version = "~> 0.2"
  name    = var.md_metadata.name_prefix
  tags    = var.md_metadata.default_tags
  region  = var.region
}
