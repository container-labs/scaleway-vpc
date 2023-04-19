# locals {
#   public_cidr_range   = cidrsubnet(var.cidr, 2, 2)
#   private_cidr_range  = cidrsubnet(var.cidr, 1, 0)
#   internal_cidr_range = cidrsubnet(var.cidr, 3, 6)
#   spare_cidr_range    = cidrsubnet(var.cidr, 3, 7)
# }

# module "public_subnets_cidr" {
#   source = "hashicorp/subnets/cidr"

#   base_cidr_block = local.public_cidr_range
#   networks = local.create_public ? [
#     for az, mask in zipmap(local.azs, local.num_azs_to_mask_bits[length(local.azs)]) : {
#       name     = az
#       new_bits = mask
#     }
#   ] : []
# }
