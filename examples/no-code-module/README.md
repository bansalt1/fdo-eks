<!-- BEGIN_TF_DOCS -->
# No-Code Module - Terraform Enterprise AWS EKS FDO

## What is this?

This is a No-Code ready module for creating a fully functional K8s cluster on AWS utilizing EKS with Terraform Enterprise FDO based on this [TFC module](https://app.terraform.io/app/hashicorp-support-eng/registry/modules/private/hashicorp-support-eng/fdo-eks/aws).

### Prerequisites

Before proceeding with this version of this module (2.0.0), ensure you have the following prerequisites in place:

This module requires deployment to our personal AWS Sandbox accounts.

- Request a sandbox account [here](https://doormat.hashicorp.services/aws/account/sbx) if you don't yet have one.
- Deploy the [base-infrastructure-aws-personal](https://app.terraform.io/app/hashicorp-support-eng/registry/modules/private/hashicorp-support-eng/base-infrastructure-aws-personal/team/) module into your project within the `hashicorp-support-eng` organization in [TFC](https://app.terraform.io/app/hashicorp-support-eng) by clicking the `provision workspace` button in the no-code module registry and following the prompts, with the suggested naming convention of `aws-sbx-base-infra-<TFC_USERNAME>`
  - Within the workspace general settings, set `Remote state sharing` to `Share with all workspaces in this organization`.
  - Within Destruction and Deletion settings, set `Allow destroy plans` to `False` under `Destroy infrastructure` section.

At this time, three variables are required to spin up a basic deployment.

Example required variables below

```
tfe_release_tag           = v202411-2
doormat_account_name      = aws_johnny_test
base_infra_workspace_name = aws-sbx-base-infra-JohnnyG
```

## How to deploy

- Open [this module in the Private Registry of our organization](https://app.terraform.io/app/hashicorp-support-eng/registry/modules/private/hashicorp-support-eng/fdo-eks-nocode/aws/), `hashicorp-support-eng` in TFC.
- Click on <ins>Provision Workspace</ins> on the top right.
  - Configure your required variables
- Click on <ins>Next: Workspace settings</ins>.
  - Provide a name for your workspace.
  - Select your TFC Project to associate with this workspace.
  - Optionally, enter a description and choose your apply method.
  - Click on <ins>Create workspace</ins> to finalize the setup.
- At this point, your workspace will attempt to plan. It will fail since there are no credentials attached to it via Doormat.
- On your workstation, Run the following commands: _Be sure to replace $PERSONAL-AWS-SBX-ACCT with your personal aws sandbox account name and the $WORKSPACE_NAME with the workspace name set in the Workspace settings._
- `doormat login`
- `doormat aws tf-push -a $PERSONAL-AWS-SBX-ACCT -w $WORKSPACE_NAME -o hashicorp-support-eng`
- Now that your credentials are uploaded to the workspace, click start <ins>Start New Run</ins>. _If you need to specify any variables, now would be the time to do so before clicking <ins>Start New Run</ins>._
- Congrats! Your run should be applying at this point.

## Post Deployment

- After the apply operation is finished, the module is set up to show several outputs. These [outputs](#outputs) are marked as steps to complete the cluster configuration.
- Running those commands on your local machine in the numbered order will configure your local access to the Kubernetes cluster and set up the initial admin user for the Terraform Enterprise application.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.82.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-enterprise-fdo"></a> [terraform-enterprise-fdo](#module\_terraform-enterprise-fdo) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [terraform_remote_state.base-infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_infra_workspace_name"></a> [base\_infra\_workspace\_name](#input\_base\_infra\_workspace\_name) | (Required) The name of the base infrastructure workspace in Terraform Cloud | `string` | n/a | yes |
| <a name="input_doormat_account_name"></a> [doormat\_account\_name](#input\_doormat\_account\_name) | (Required) The doormat account name (e.g., aws\_johnny\_test) | `string` | n/a | yes |
| <a name="input_postgresql_version"></a> [postgresql\_version](#input\_postgresql\_version) | (Optional) The version of PostgreSQL to install | `string` | `"16.6"` | no |
| <a name="input_tfe_cpu_request"></a> [tfe\_cpu\_request](#input\_tfe\_cpu\_request) | (Optional) CPU request for TFE pods | `number` | `1` | no |
| <a name="input_tfe_iact_token"></a> [tfe\_iact\_token](#input\_tfe\_iact\_token) | (Optional) The initial admin token for TFE | `string` | `"tfsupport"` | no |
| <a name="input_tfe_memory_request"></a> [tfe\_memory\_request](#input\_tfe\_memory\_request) | (Optional) Memory request for TFE pods | `string` | `"2000Mi"` | no |
| <a name="input_tfe_release_tag"></a> [tfe\_release\_tag](#input\_tfe\_release\_tag) | (REQUIRED) The version of FDO to install. https://developer.hashicorp.com/terraform/enterprise/releases (eg v202411-2) | `string` | `"v202411-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_region"></a> [region](#output\_region) | AWS region from base-infra |
| <a name="output_step_1_create_cred_file"></a> [step\_1\_create\_cred\_file](#output\_step\_1\_create\_cred\_file) | Command used to set local AWS cred file that `kubectl` requires for permissions. |
| <a name="output_step_2_update_kubectl"></a> [step\_2\_update\_kubectl](#output\_step\_2\_update\_kubectl) | Command used to update kubectl config with EKS cluster details. |
| <a name="output_step_3_create_admin_user"></a> [step\_3\_create\_admin\_user](#output\_step\_3\_create\_admin\_user) | URL to create the initial admin user. |
| <a name="output_step_4_app_url"></a> [step\_4\_app\_url](#output\_step\_4\_app\_url) | URL to access the TFE app. |
<!-- END_TF_DOCS -->