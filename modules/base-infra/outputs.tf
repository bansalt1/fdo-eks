output "vpc" {
  description = "VPC details"
  value = {
    vpc_id                      = data.aws_vpc.existing.id
    private_subnets             = var.existing_private_subnets
    public_subnets              = var.existing_public_subnets
    database_subnets            = var.existing_database_subnets
    private_subnets_cidr_blocks = [for subnet in data.aws_subnet.private : subnet.cidr_block]
    public_subnets_cidr_blocks  = [for subnet in data.aws_subnet.public : subnet.cidr_block]
    database_subnet_group       = local.infra_outputs.tfe_settings.database_subnet_group
    elasticache_subnet_group    = local.infra_outputs.tfe_settings.elasticache_subnet_group
  }
}

output "ssm" {
  description = "SSM details"
  value = {
    security_group = data.aws_security_group.ssm
    role           = aws_iam_role.ssm
  }
}

output "rds" {
  value = module.rds
}

output "route53_zone_ns" {
  value = data.aws_route53_zone.dns_zone.name_servers
}

output "acm_wildcard_arn" {
  description = "The ARN for the ACM wildcard certificate."
  value       = module.acm_wildcard.acm_certificate_arn
}

output "user_name" {
  value = local.user_name
}

output "user_email" {
  value = local.user_email
}

output "region" {
  value = var.region
}
