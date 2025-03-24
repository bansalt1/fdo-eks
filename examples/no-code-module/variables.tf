####################
# TFE Variables    #
####################

variable "tfe_release_tag" {
  description = "(REQUIRED) The version of FDO to install. https://developer.hashicorp.com/terraform/enterprise/releases (eg v202411-2)"
  type        = string
  default     = "v202411-2"
}

variable "tfe_license" {
  type        = string
  description = "(Optional) The license for TFE, defaults to the terraform teal license"
}

variable "tfe_iact_token" {
  type        = string
  description = "(Optional) The initial admin token for TFE"
  default     = "tfsupport"
}

variable "postgresql_version" {
  type        = string
  description = "(Optional) The version of PostgreSQL to install"
  # renovate: datasource=endoflife-date depName=amazon-rds-postgresql versioning=loose
  default = "16.6"
}

variable "base_infra_workspace_name" {
  type        = string
  description = "(Required) The name of the base infrastructure workspace in Terraform Cloud"
}

variable "doormat_account_name" {
  type        = string
  description = "(Required) The doormat account name (e.g., aws_johnny_test)"
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