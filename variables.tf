####################
# General          #
####################

variable "tags" {
  description = "(Optional) Any custom tags that should be added to all of the resources."
  type        = map(string)
  default     = {}
}

variable "namespace" {
  type        = string
  description = "The namespace to deploy TFE into"
  default     = "terraform-enterprise"
}

variable "base_infra_workspace_name" {
  type        = string
  description = "The name of the base infrastructure workspace in Terraform Cloud"
}

####################
# NETWORK AND DNS  #
####################

variable "region" {
  type        = string
  description = "The AWS region to deploy resources to"
}

variable "zone_name" {
  description = "(Required) Route53 zone name for DNS records (e.g., example.hashidemos.io)"
  type        = string
}

variable "availability_zones" {
  type        = set(string)
  description = "(Optional) List of AWS availability zone suffixes (e.g., [\"a\", \"b\", \"c\"])"
  default     = ["a", "b", "c"]
}

variable "additional_subnet_types" {
  type        = set(string)
  description = "(Optional) Additional subnet types to create beyond the default public/private/database subnets"
  default     = ["elasticache"]
}

####################
# EKS CLUSTER      #
####################

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster"
  # renovate: datasource=endoflife-date depName=amazon-eks versioning=loose
  default = "1.32"
}

variable "instance_type" {
  description = "Instance type for the EKS managed node group"
  type        = list(string)
  default     = ["t3a.2xlarge"]
}

variable "node_count" {
  description = "(Optional) The number of pods when using active-active."
  type        = number
  default     = 1
}

variable "helm_chart_version" {
  type        = string
  description = "The version of the TFE Helm chart to deploy"
  # renovate: helm: registryUrl=https://helm.releases.hashicorp.com depName=terraform-enterprise
  default = "1.6.0"
}

####################
# Postgres         #
####################

variable "postgresql_version" {
  type        = string
  description = "The version of PostgreSQL to use for RDS"
  # renovate: datasource=endoflife-date depName=amazon-rds-postgresql versioning=loose
  default = "16.8"
}

variable "db_instance_size" {
  type        = string
  description = "The instance class to use for the RDS instance"
  default     = "db.t3.small"
}

variable "db_port" {
  type        = string
  description = "The port number for PostgreSQL database connections"
  default     = "5432"
}

####################
# Redis            #
####################

variable "redis_use_password_auth" {
  description = "(Optional) Whether or not to use password authentication when connecting to Redis."
  type        = bool
  default     = true
}

variable "redis_use_tls" {
  description = "(Optional) Whether or not to use TLS when connecting to Redis."
  type        = bool
  default     = true
}

variable "redis_port" {
  type        = string
  description = "The port number for Redis database connections"
  default     = "6379"
}

####################
# TFE Settings     #
####################

variable "encryption_password" {
  type        = string
  description = "Password used for encryption of sensitive data in the database"
  default     = "SUPERSECRET"
}

variable "tfe_iact_token" {
  type        = string
  description = "Initial Admin Creation Token for first-time TFE setup"
  default     = "tfsupport"
}

####################
# Docker Registry  #
####################

variable "docker_registry" {
  type        = string
  default     = "images.releases.hashicorp.com"
  description = "Appending of /hashicorp needed to registry URL for Docker to succesfully pull image via Terraform."
}

variable "image" {
  type        = string
  description = "The Docker image name for TFE"
  default     = "hashicorp/terraform-enterprise"
}

variable "tag" {
  type        = string
  description = "The Docker image tag for TFE. Must be explicitly set as no latest tag is available"
  # renovate: datasource=custom.terraform-enterprise depName=terraform-enterprise versioning=loose
  default = "v202411-2"
}

variable "docker_registry_username" {
  type        = string
  description = "Username for Docker registry authentication"
  default     = "terraform"
}

variable "tfe_license" {
  type        = string
  sensitive   = true
  default     = "02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJZVE26CNPJDGWTKUNN2FURCONVHVGMBRLFVEK52MK5ETITSXKV2E23KRGVNGUUTILJKFCMSNNVIXQSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJEZVU2SONRGTETJVJV4TA52ONJRTGTCXKJUFU3KFORNGUTTJJZBTANC2K5KTEWL2MRWVUR2ZGRNEIRLJJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SRORGVISLUJVKGYVKNNJATMTSEJU3E22SFOVHFIWL2JZKECNKNKRGTEV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJGBGFIRLZJRKEKNKWIRAXOT3KIF3U62SBO5LWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKM52E2RCFORGVI2CVJVCECNSNIRATMTKEIJQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJTXITKEIV2E2VDIKVGUIQJWJVCECNSNIRBGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZJGYY3OJJUFU3JZPFRFGSLTJFWVU42ZK5SHUSLKOA3WMWBQHUXFMOLZGBTGER2FNFXHIYKXJJUXGSSNPFGXGNRXNZHHMYLQPFCTCZTUGNZVINCZKJYWEUTELF2FGZDSOFRG6QSSGJGVMYRXOJ3DE4LEKZSHMMLSINFS63JUKE4EEWDVMZLHM6LJIZATKMLEIFVWGYJUMRLDAMZTHBIHO3KWNRQXMSSQGRYEU6CJJE4UINSVIZGFKYKWKBVGWV2KORRUINTQMFWDM32PMZDW4SZSPJIEWSSSNVDUQVRTMVNHO4KGMUVW6N3LF5ZSWQKUJZUFAWTHKMXUWVSZM4XUWK3MI5IHOTBXNJBHQSJXI5HWC2ZWKVQWSYKIN5SWWMCSKRXTOMSEKE6T2"
  description = "License URL https://license.hashicorp.services/customers/7f3e3c93-0677-dafa-f3b4-8ee6c7fdf8d1 Exp 1.18.28"
}

####################
# Resource Limits  #
####################
variable "tfe_cpu_request" {
  description = "(Optional) CPU request for TFE pods"
  type        = number
  default     = 1
}

variable "tfe_memory_request" {
  description = "(Optional) Memory request for TFE pods"
  type        = string
  default     = "2000Mi"
}
