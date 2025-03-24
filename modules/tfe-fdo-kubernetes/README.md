<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.tfe](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.tfe](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.docker_registry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_hostname"></a> [db\_hostname](#input\_db\_hostname) | The hostname of the RDS instance | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create in RDS | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | The password for database access | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port number the database is listening on | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | The username for database access | `string` | n/a | yes |
| <a name="input_docker_registry"></a> [docker\_registry](#input\_docker\_registry) | The URL of the Docker registry containing the TFE image | `string` | n/a | yes |
| <a name="input_docker_registry_username"></a> [docker\_registry\_username](#input\_docker\_registry\_username) | Username for Docker registry authentication | `string` | n/a | yes |
| <a name="input_encryption_password"></a> [encryption\_password](#input\_encryption\_password) | n/a | `string` | `"SUPERSECRET"` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Version of the TFE Helm chart to deploy | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The TFE image name | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ID of the KMS key to use for TFE Object Storage | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"terraform-enterprise"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes to deploy for TFE | `number` | n/a | yes |
| <a name="input_redis_host"></a> [redis\_host](#input\_redis\_host) | Hostname of the Redis instance | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | Password for Redis authentication | `string` | n/a | yes |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Port number the Redis instance is listening on | `string` | n/a | yes |
| <a name="input_redis_use_auth"></a> [redis\_use\_auth](#input\_redis\_use\_auth) | n/a | `bool` | `true` | no |
| <a name="input_redis_use_tls"></a> [redis\_use\_tls](#input\_redis\_use\_tls) | n/a | `bool` | `true` | no |
| <a name="input_redis_user"></a> [redis\_user](#input\_redis\_user) | Username for Redis authentication | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The name of the S3 bucket for TFE object storage | `string` | n/a | yes |
| <a name="input_service_annotations"></a> [service\_annotations](#input\_service\_annotations) | Annotations to add to the TFE Kubernetes service | `map(string)` | `{}` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | The TFE image tag to deploy | `string` | n/a | yes |
| <a name="input_tfe_cpu_request"></a> [tfe\_cpu\_request](#input\_tfe\_cpu\_request) | (Optional) CPU request for TFE pods | `number` | `1` | no |
| <a name="input_tfe_hostname"></a> [tfe\_hostname](#input\_tfe\_hostname) | Hostname of the TFE instance | `string` | n/a | yes |
| <a name="input_tfe_iact_subnets"></a> [tfe\_iact\_subnets](#input\_tfe\_iact\_subnets) | Subnet CIDR blocks where Initial Admin Creation Token can be used | `string` | `""` | no |
| <a name="input_tfe_iact_token"></a> [tfe\_iact\_token](#input\_tfe\_iact\_token) | n/a | `string` | `"tfsupport"` | no |
| <a name="input_tfe_license"></a> [tfe\_license](#input\_tfe\_license) | The TFE license string | `string` | n/a | yes |
| <a name="input_tfe_memory_request"></a> [tfe\_memory\_request](#input\_tfe\_memory\_request) | (Optional) Memory request for TFE pods | `string` | `"2000Mi"` | no |
| <a name="input_tls_ca_cert"></a> [tls\_ca\_cert](#input\_tls\_ca\_cert) | TLS CA certificate for TFE | `string` | n/a | yes |
| <a name="input_tls_cert"></a> [tls\_cert](#input\_tls\_cert) | TLS certificate for TFE | `string` | n/a | yes |
| <a name="input_tls_cert_key"></a> [tls\_cert\_key](#input\_tls\_cert\_key) | TLS certificate private key for TFE | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfe_namespace_id"></a> [tfe\_namespace\_id](#output\_tfe\_namespace\_id) | The ID of the Terraform Enterprise namespace |
<!-- END_TF_DOCS -->