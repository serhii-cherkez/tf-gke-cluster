output "workload_identity_pool_provider" {
  value = module.workload_identity.workload_identity_pool_provider
}

output "service_account" {
  value = module.workload_identity.service_account
}