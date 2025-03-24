####################
# RDS DB           #
####################

variable "db_name" {
  description = "The name of the database to create in RDS"
  type        = string
}

variable "db_port" {
  description = "The port number the database is listening on"
  type        = string
}

variable "db_user" {
  description = "The username for database access"
  type        = string
}

variable "db_password" {
  description = "The password for database access"
  type        = string
}

variable "db_hostname" {
  description = "The hostname of the RDS instance"
  type        = string
}

variable "s3_bucket" {
  description = "The name of the S3 bucket for TFE object storage"
  type        = string
}

####################
# Object Storage   #
####################

variable "kms_key_id" {
  description = "The ID of the KMS key to use for TFE Object Storage"
  type        = string
}

####################
# Docker Registry  #
####################

variable "docker_registry" {
  description = "The URL of the Docker registry containing the TFE image"
  type        = string
}

variable "docker_registry_username" {
  description = "Username for Docker registry authentication"
  type        = string
}

variable "tfe_license" {
  description = "The TFE license string"
  type        = string
}

variable "image" {
  description = "The TFE image name"
  type        = string
}

variable "tag" {
  description = "The TFE image tag to deploy"
  type        = string
}

####################
# TFE Settings     #
####################

variable "tfe_hostname" {
  description = "Hostname of the TFE instance"
  type        = string
}

variable "node_count" {
  description = "Number of nodes to deploy for TFE"
  type        = number
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "encryption_password" {
  type    = string
  default = "SUPERSECRET"
}

variable "tfe_iact_token" {
  type    = string
  default = "tfsupport"
}

####################
# Helm             #
####################

variable "helm_chart_version" {
  description = "Version of the TFE Helm chart to deploy"
  type        = string
}

variable "namespace" {
  type    = string
  default = "terraform-enterprise"
}

variable "tfe_iact_subnets" {
  description = "Subnet CIDR blocks where Initial Admin Creation Token can be used"
  type        = string
  default     = ""
}

variable "service_annotations" {
  description = "Annotations to add to the TFE Kubernetes service"
  type        = map(string)
  default     = {}
}

####################
# TLS              #
####################

variable "tls_cert" {
  description = "TLS certificate for TFE"
  type        = string
}

variable "tls_ca_cert" {
  description = "TLS CA certificate for TFE"
  type        = string
}

variable "tls_cert_key" {
  description = "TLS certificate private key for TFE"
  type        = string
}

####################
# Redis            #
####################

variable "redis_host" {
  description = "Hostname of the Redis instance"
  type        = string
}

variable "redis_port" {
  description = "Port number the Redis instance is listening on"
  type        = string
}

variable "redis_password" {
  description = "Password for Redis authentication"
  type        = string
}

variable "redis_user" {
  description = "Username for Redis authentication"
  type        = string
  default     = ""
}

variable "redis_use_auth" {
  type    = bool
  default = true
}

variable "redis_use_tls" {
  type    = bool
  default = true
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