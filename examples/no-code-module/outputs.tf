############
# Outputs  #
############

output "step_1_create_cred_file" {
  description = "Command used to set local AWS cred file that `kubectl` requires for permissions."
  value       = "doormat aws cred-file add-profile --set-default -a ${var.doormat_account_name}"
}

output "step_2_update_kubectl" {
  description = "Command used to update kubectl config with EKS cluster details."
  value       = "aws eks --region ${local.infra_outputs.region} update-kubeconfig --name ${module.terraform-enterprise-fdo.cluster_name}"
}

output "step_3_create_admin_user" {
  description = "URL to create the initial admin user."
  value       = "https://${module.terraform-enterprise-fdo.random_pet}.${local.infra_outputs.zone_name}/admin/account/new?token=${var.tfe_iact_token}"
}

output "step_4_app_url" {
  description = "URL to access the TFE app."
  value       = "https://${module.terraform-enterprise-fdo.random_pet}.${local.infra_outputs.zone_name}"
}

output "region" {
  description = "AWS region from base-infra"
  value       = local.infra_outputs.region
}
