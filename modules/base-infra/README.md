<!-- BEGIN_TF_DOCS -->
# base-infra

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_wildcard"></a> [acm\_wildcard](#module\_acm\_wildcard) | terraform-aws-modules/acm/aws | 5.1.1 |
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws//modules/db_subnet_group | 6.10.0 |
| <a name="module_route53_records_only"></a> [route53\_records\_only](#module\_route53\_records\_only) | terraform-aws-modules/acm/aws | 5.1.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloud_watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.base-infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_subnet_types"></a> [additional\_subnet\_types](#input\_additional\_subnet\_types) | List of types of subnets to create, for each subnet type, a subnet will be created in each availability zone defined in `availability_zones`. The public, private, and db subnets are created by default and are not modified by this variable. | `list(string)` | <pre>[<br/>  "elasticache"<br/>]</pre> | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zone id letters to use to create subnets | `list(string)` | n/a | yes |
| <a name="input_base_infra_workspace_name"></a> [base\_infra\_workspace\_name](#input\_base\_infra\_workspace\_name) | Name of the base infrastructure workspace | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | The tags to apply to all resources. | `map(any)` | `{}` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | The DNS name to use for the Route53 record | `string` | n/a | yes |
| <a name="input_existing_database_subnets"></a> [existing\_database\_subnets](#input\_existing\_database\_subnets) | List of existing database subnet IDs | `list(string)` | n/a | yes |
| <a name="input_existing_private_subnets"></a> [existing\_private\_subnets](#input\_existing\_private\_subnets) | List of existing private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_existing_public_subnets"></a> [existing\_public\_subnets](#input\_existing\_public\_subnets) | List of existing public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_existing_vpc_id"></a> [existing\_vpc\_id](#input\_existing\_vpc\_id) | ID of existing VPC to use | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the infrastructure to | `string` | n/a | yes |
| <a name="input_resource_name"></a> [resource\_name](#input\_resource\_name) | Name generated by random\_pet from root module | `string` | n/a | yes |
| <a name="input_root_cidr"></a> [root\_cidr](#input\_root\_cidr) | CIDR block to use for the vpc | `string` | `"10.0.0.0/16"` | no |
| <a name="input_ssm-role-suffix"></a> [ssm-role-suffix](#input\_ssm-role-suffix) | Value to append to the SSM role name, useful for deploying base infrastructure in another region where IAM names still conflict. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Any custom tags that should be added to all of the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_wildcard_arn"></a> [acm\_wildcard\_arn](#output\_acm\_wildcard\_arn) | The ARN for the ACM wildcard certificate. |
| <a name="output_rds"></a> [rds](#output\_rds) | n/a |
| <a name="output_region"></a> [region](#output\_region) | n/a |
| <a name="output_route53_zone_ns"></a> [route53\_zone\_ns](#output\_route53\_zone\_ns) | n/a |
| <a name="output_ssm"></a> [ssm](#output\_ssm) | SSM details |
| <a name="output_user_email"></a> [user\_email](#output\_user\_email) | n/a |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | VPC details |
<!-- END_TF_DOCS -->