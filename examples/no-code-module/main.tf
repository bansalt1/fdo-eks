############################################################
# Pulls data from base-infra Terrafrom Cloud workspace     #
############################################################

data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "terraform_remote_state" "base-infra" {
  backend = "remote"

  config = {
    organization = "hashicorp-support-eng"
    workspaces = {
      name = var.base_infra_workspace_name
    }
  }
}

############################################################
# Sets locals from base-infra                              #
############################################################

locals {
  infra_outputs = data.terraform_remote_state.base-infra.outputs
}

############################################################
# TFE AWS EKS FDO Module                                   #
############################################################

module "terraform-enterprise-fdo" {
  # Enabled for HCP TF deployment (default)
  source  = "app.terraform.io/hashicorp-support-eng/fdo-eks/aws"
  version = "2.0.0-alpha"

  # Comment out above and uncomment below for local deployment
  # source                    = "../../"

  region                    = local.infra_outputs.region
  zone_name                 = local.infra_outputs.zone_name
  tag                       = var.tfe_release_tag
  base_infra_workspace_name = var.base_infra_workspace_name

  ### Optional variables
  # tfe_license        = var.tfe_license
  # tfe_iact_token     = "tfsupport"
  # postgresql_version = var.postgresql_version
  # tfe_cpu_request    = var.tfe_cpu_request
  # tfe_memory_request = var.tfe_memory_request
}
