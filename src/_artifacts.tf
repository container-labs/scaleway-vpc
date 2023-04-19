locals {
  data_infrastructure = {
    id              = scaleway_vpc_private_network.main.id
    cidr            = scaleway_vpc_public_gateway_dhcp.main.subnet
    private_subnets = scaleway_vpc_private_network.main
    # public_subnets   = local.public_subnets
    # internal_subnets = local.internal_subnets
  }

  artifact = {
    data = {
      infrastructure = local.data_infrastructure
      # TODO: remove the below three fields when the scw-vpc artifact-definition exists
      grn            = "projects/fooobar/one/bizbaz/yep"
      private_services_access = {}
      private_service_connect_ip = "five"
    }
    specs = {
      scw = {
        region = var.region
        zones  = local.private_region_to_zones[var.region]
      }
    }
  }
}

resource "massdriver_artifact" "network" {
  field                = "network"
  provider_resource_id = scaleway_vpc_private_network.main.id
  name                 = "SCW VPC Network"
  artifact             = jsonencode(local.artifact)
}
