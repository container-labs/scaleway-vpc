#
# https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_gateway_network

# only supporting one zone in a region for now
# the "default" zone is the only one that can be used to peer with databases
resource "scaleway_vpc_private_network" "main" {
  name = var.md_metadata.name_prefix
}

resource "scaleway_vpc_public_gateway_ip" "main" {
}

# https://www.scaleway.com/en/docs/compute/instances/how-to/use-private-networks/#how-to-configure-the-private-network-interface-on-your-instances
#  It is therefore recommended that you configure your Private Network using IPs from the following private IP ranges:
# 192.168.0.0 - 192.168.255.255 (65,536 IP addresses) and
# 172.16.0.0 - 172.31.255.255 (1,048,576 IP addresses)
resource "scaleway_vpc_public_gateway_dhcp" "main" {
  subnet             = "192.168.1.0/24"
  push_default_route = true
}

# The VPC Public Gateway is a building block for your infrastructure
# on Scaleway's shared public cloud. It provides a set of managed
# network services and features for Scaleway's Private Networks such as DHCP, NAT and routing.
resource "scaleway_vpc_public_gateway" "main" {
  name  = var.md_metadata.name_prefix
  type  = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.main.id
}

# A Gateway Network represents the connection of a Private Network
# to a VPC Public Gateway. It holds configuration options relative
# to this specific connection, such as the DHCP configuration.
resource "scaleway_vpc_gateway_network" "main" {
  gateway_id         = scaleway_vpc_public_gateway.main.id
  private_network_id = scaleway_vpc_private_network.main.id
  dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id
  cleanup_dhcp       = true
  enable_masquerade  = true
  zone               = local.zone
}
