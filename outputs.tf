output "random_pet" {
  value = random_pet.name.id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "user_email" {
  value = local.user_email
}

output "zone_name" {
  value = var.zone_name
}