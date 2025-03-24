provider "tfe" {
  token = data.external.tfe_token.result["token"]  # Get token dynamically
}

# Fetch TFE token from the cluster
data "external" "tfe_token" {
  program = ["sh", "-c", <<EOT
    POD_NAME=$(kubectl get pods -n tfe -l app=terraform-enterprise -o jsonpath='{.items[0].metadata.name}')
    kubectl exec -n terraform-enterprise -it $POD_NAME -- tfectl admin token | tr -d '\r\n'
  EOT
  ]
}

resource "tfe_organization_membership" "admin_user" {
  organization = "test-org"
  email        = "tarun.bansal@hashicorp.com"
}

# Generate a random password for the admin user
resource "random_password" "admin_password" {
  length  = 16
  special = true
}

resource "tfe_team" "admin_team" {
  name         = "admins"
  organization = "your-org-name"
}

resource "tfe_team_organization_member" "add_admin_to_team" {
  team_id        = tfe_team.admin_team.id
  #organization   = "test-org"
  #email          = tfe_organization_membership.admin_user.email
}

# Output the generated password securely
output "admin_password" {
  value       = random_password.admin_password.result
  #sensitive   = true
  description = "The generated admin password (keep it safe)."
}
