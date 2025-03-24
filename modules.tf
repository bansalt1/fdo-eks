module "base-infra" {
  source = "./modules/base-infra"

  availability_zones      = local.infra_outputs.vpc.azs
  additional_subnet_types = var.additional_subnet_types
  region                  = local.infra_outputs.region
  common_tags             = local.tags
  dns_zone                = local.infra_outputs.zone_name
  resource_name           = random_pet.name.id

  # Add these new variables to use existing VPC
  existing_vpc_id           = local.infra_outputs.vpc.vpc_id
  existing_private_subnets  = local.infra_outputs.vpc.private_subnets
  existing_public_subnets   = local.infra_outputs.vpc.public_subnets
  existing_database_subnets = local.infra_outputs.vpc.database_subnets
  base_infra_workspace_name = var.base_infra_workspace_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = "${random_pet.name.id}-cluster"
  cluster_version = var.kubernetes_version

  vpc_id                                   = module.base-infra.vpc.vpc_id
  subnet_ids                               = module.base-infra.vpc.private_subnets
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name           = "${random_pet.name.id}"
      instance_types = var.instance_type
      min_size       = 1
      max_size       = 3
      desired_size   = var.node_count
    }
  }

  tags = local.tags
}

module "object_storage" {
  source = "./modules/object_storage"

  tags                           = local.tags
  iam_instance_profile_role_name = module.eks.eks_managed_node_groups["one"].iam_role_name
  prefix                         = random_pet.name.id
}

module "postgresql" {
  source                = "./modules/postgresql"
  engine_version        = var.postgresql_version
  db_instance_size      = var.db_instance_size
  db_port               = var.db_port
  prefix                = random_pet.name.id
  tags                  = local.tags
  vpc_id                = module.base-infra.vpc.vpc_id
  database_subnet_group = module.base-infra.vpc.database_subnet_group
  cidr_blocks           = module.base-infra.vpc.private_subnets_cidr_blocks
}

module "redis" {
  source                  = "./modules/redis"
  prefix                  = random_pet.name.id
  subnet_group_name       = module.base-infra.vpc.elasticache_subnet_group
  redis_use_password_auth = var.redis_use_password_auth
  redis_port              = var.redis_port
  vpc_id                  = module.base-infra.vpc.vpc_id
  security_groups         = [module.eks.node_security_group_id]
  tags                    = local.tags
}

module "tfe-fdo-kubernetes" {
  source                   = "./modules/tfe-fdo-kubernetes"
  docker_registry          = var.docker_registry
  docker_registry_username = var.docker_registry_username
  tag                      = var.tag
  image                    = var.image
  helm_chart_version       = var.helm_chart_version
  db_hostname              = module.postgresql.db_hostname
  db_name                  = module.postgresql.db_name
  db_password              = module.postgresql.db_password
  db_port                  = var.db_port
  db_user                  = module.postgresql.db_user
  kms_key_id               = module.object_storage.kms_key_id
  node_count               = var.node_count
  redis_host               = module.redis.redis_host
  redis_password           = module.redis.redis_password
  redis_port               = var.redis_port
  redis_use_auth           = var.redis_use_password_auth
  redis_use_tls            = var.redis_use_tls
  s3_bucket                = module.object_storage.s3_bucket
  region                   = var.region
  tfe_iact_token           = var.tfe_iact_token

  # Resource limits
  tfe_cpu_request    = var.tfe_cpu_request
  tfe_memory_request = var.tfe_memory_request

  service_annotations = {
    "service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"         = module.base-infra.acm_wildcard_arn
    "service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol" = "ssl"
  }

  tfe_hostname = local.tfe_hostname
  tfe_license  = var.tfe_license
  tls_cert     = base64encode(tls_self_signed_cert.tfe.cert_pem)
  tls_ca_cert  = base64encode(tls_self_signed_cert.tfe.cert_pem)
  tls_cert_key = base64encode(tls_self_signed_cert.tfe.private_key_pem)
}
