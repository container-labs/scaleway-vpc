locals {
  data_infrastructure = {
    id   = module.virtual_network.id
    cidr = module.virtual_network.cidr
    # private_subnets = scaleway_vpc_private_network.main
    # public_subnets   = local.public_subnets
    # internal_subnets = local.internal_subnets
  }

  artifact = {
    data = {
      infrastructure = local.data_infrastructure
      # TODO: remove the below three fields when the scw-vpc artifact-definition exists
      grn                        = "projects/fooobar/one/bizbaz/yep"
      private_services_access    = {}
      private_service_connect_ip = "five"
    }
    specs = {
      scaleway = {
        region = var.region
        zones  = module.virtual_network.zones
      }
    }
  }
}

resource "massdriver_artifact" "network" {
  field                = "network"
  provider_resource_id = module.virtual_network.id
  name                 = "SCW VPC Network"
  artifact             = jsonencode(local.artifact)
}
