locals {

  // This is an easy way to make sure that we have all of the required subnet types, but allow for adding more options
  // via the `additional_subnet_types` variable.
  subnet_types = concat(var.additional_subnet_types, ["public", "private", "db"])

  // This allows us to create an exhaustive list of combinations of availability zones to subnet types so that we can
  // create a subnet of each type in each availability zone.
  subnets = [for subnet in setproduct(var.availability_zones, local.subnet_types) : join("_", subnet)]

  // Each of these blocks allows us to tag resources as private, public, etc.
  public_tags = merge({
    Type = "public"
    },
    var.common_tags
  )

  private_tags = merge({
    Type = "private"
    },
    var.common_tags
  )

  database_tags = merge({
    Usage = "database"
    },
    var.common_tags
  )

  elasticache_tags = merge({
    Usage = "elasticache"
    },
    var.common_tags
  )

}
