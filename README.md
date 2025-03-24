<!-- BEGIN_TF_DOCS -->
# Terraform Enterprise - AWS EKS FDO

### NOTE: Starting with version 2.0.0, this module requires a personal AWS Sandbox account and can not / should not be used the shared AWS account.

## What is this?

This is the base module that is used by the `terraform-aws-eks-fdo-nocode` [module](https://app.terraform.io/app/hashicorp-support-eng/registry/modules/private/hashicorp-support-eng/eks-fdo-nocode/aws/) to deploy a functional k8s based instance of Terraform Enterprise FDO. This module can be referenced directly if so desired.

[K8s internal install guide](https://hashicorp.atlassian.net/wiki/spaces/IPL/pages/2557116565/Kubernetes+Install+Guide+Internal+Alpha)
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.82.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.35.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.82.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.35.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base-infra"></a> [base-infra](#module\_base-infra) | ./modules/base-infra | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 20.31.4 |
| <a name="module_object_storage"></a> [object\_storage](#module\_object\_storage) | ./modules/object_storage | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | ./modules/postgresql | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ./modules/redis | n/a |
| <a name="module_tfe-fdo-kubernetes"></a> [tfe-fdo-kubernetes](#module\_tfe-fdo-kubernetes) | ./modules/tfe-fdo-kubernetes | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [tls_private_key.tfe](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.tfe](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [kubernetes_service.tfe](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |
| [terraform_remote_state.base-infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_subnet_types"></a> [additional\_subnet\_types](#input\_additional\_subnet\_types) | (Optional) Additional subnet types to create beyond the default public/private/database subnets | `set(string)` | <pre>[<br/>  "elasticache"<br/>]</pre> | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) List of AWS availability zone suffixes (e.g., ["a", "b", "c"]) | `set(string)` | <pre>[<br/>  "a",<br/>  "b",<br/>  "c"<br/>]</pre> | no |
| <a name="input_base_infra_workspace_name"></a> [base\_infra\_workspace\_name](#input\_base\_infra\_workspace\_name) | The name of the base infrastructure workspace in Terraform Cloud | `string` | n/a | yes |
| <a name="input_db_instance_size"></a> [db\_instance\_size](#input\_db\_instance\_size) | The instance class to use for the RDS instance | `string` | `"db.t3.small"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port number for PostgreSQL database connections | `string` | `"5432"` | no |
| <a name="input_docker_registry"></a> [docker\_registry](#input\_docker\_registry) | Appending of /hashicorp needed to registry URL for Docker to succesfully pull image via Terraform. | `string` | `"images.releases.hashicorp.com"` | no |
| <a name="input_docker_registry_username"></a> [docker\_registry\_username](#input\_docker\_registry\_username) | Username for Docker registry authentication | `string` | `"terraform"` | no |
| <a name="input_encryption_password"></a> [encryption\_password](#input\_encryption\_password) | Password used for encryption of sensitive data in the database | `string` | `"SUPERSECRET"` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | The version of the TFE Helm chart to deploy | `string` | `"1.3.4"` | no |
| <a name="input_image"></a> [image](#input\_image) | The Docker image name for TFE | `string` | `"hashicorp/terraform-enterprise"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for the EKS managed node group | `list(string)` | <pre>[<br/>  "t3a.2xlarge"<br/>]</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version to use for the EKS cluster | `string` | `"1.31"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy TFE into | `string` | `"terraform-enterprise"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | (Optional) The number of pods when using active-active. | `number` | `1` | no |
| <a name="input_postgresql_version"></a> [postgresql\_version](#input\_postgresql\_version) | The version of PostgreSQL to use for RDS | `string` | `"16.6"` | no |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | The port number for Redis database connections | `string` | `"6379"` | no |
| <a name="input_redis_use_password_auth"></a> [redis\_use\_password\_auth](#input\_redis\_use\_password\_auth) | (Optional) Whether or not to use password authentication when connecting to Redis. | `bool` | `true` | no |
| <a name="input_redis_use_tls"></a> [redis\_use\_tls](#input\_redis\_use\_tls) | (Optional) Whether or not to use TLS when connecting to Redis. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy resources to | `string` | n/a | yes |
| <a name="input_tag"></a> [tag](#input\_tag) | The Docker image tag for TFE. Must be explicitly set as no latest tag is available | `string` | `"v202411-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Any custom tags that should be added to all of the resources. | `map(string)` | `{}` | no |
| <a name="input_tfe_cpu_request"></a> [tfe\_cpu\_request](#input\_tfe\_cpu\_request) | (Optional) CPU request for TFE pods | `number` | `1` | no |
| <a name="input_tfe_iact_token"></a> [tfe\_iact\_token](#input\_tfe\_iact\_token) | Initial Admin Creation Token for first-time TFE setup | `string` | `"tfsupport"` | no |
| <a name="input_tfe_license"></a> [tfe\_license](#input\_tfe\_license) | License URL https://license.hashicorp.services/customers/7f3e3c93-0677-dafa-f3b4-8ee6c7fdf8d1 Exp 1.18.28 | `string` | `"02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJZVE26CNPJDGWTKUNN2FURCONVHVGMBRLFVEK52MK5ETITSXKV2E23KRGVNGUUTILJKFCMSNNVIXQSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJEZVU2SONRGTETJVJV4TA52ONJRTGTCXKJUFU3KFORNGUTTJJZBTANC2K5KTEWL2MRWVUR2ZGRNEIRLJJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SRORGVISLUJVKGYVKNNJATMTSEJU3E22SFOVHFIWL2JZKECNKNKRGTEV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJGBGFIRLZJRKEKNKWIRAXOT3KIF3U62SBO5LWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKM52E2RCFORGVI2CVJVCECNSNIRATMTKEIJQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJTXITKEIV2E2VDIKVGUIQJWJVCECNSNIRBGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZJGYY3OJJUFU3JZPFRFGSLTJFWVU42ZK5SHUSLKOA3WMWBQHUXFMOLZGBTGER2FNFXHIYKXJJUXGSSNPFGXGNRXNZHHMYLQPFCTCZTUGNZVINCZKJYWEUTELF2FGZDSOFRG6QSSGJGVMYRXOJ3DE4LEKZSHMMLSINFS63JUKE4EEWDVMZLHM6LJIZATKMLEIFVWGYJUMRLDAMZTHBIHO3KWNRQXMSSQGRYEU6CJJE4UINSVIZGFKYKWKBVGWV2KORRUINTQMFWDM32PMZDW4SZSPJIEWSSSNVDUQVRTMVNHO4KGMUVW6N3LF5ZSWQKUJZUFAWTHKMXUWVSZM4XUWK3MI5IHOTBXNJBHQSJXI5HWC2ZWKVQWSYKIN5SWWMCSKRXTOMSEKE6T2"` | no |
| <a name="input_tfe_memory_request"></a> [tfe\_memory\_request](#input\_tfe\_memory\_request) | (Optional) Memory request for TFE pods | `string` | `"2000Mi"` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) Route53 zone name for DNS records (e.g., example.hashidemos.io) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_random_pet"></a> [random\_pet](#output\_random\_pet) | n/a |
| <a name="output_user_email"></a> [user\_email](#output\_user\_email) | n/a |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | n/a |
<!-- END_TF_DOCS --># fdo-eks
# fdo-eks
