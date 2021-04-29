output "bastionA_IP" {
  value = module.compute.bastionA_IP
}

output "bastionB_IP" {
  value = module.compute.bastionB_IP
}

output "bastionC_IP" {
  value = module.compute.bastionC_IP
}

output "AppA_IP" {
  value = module.compute.AppA_IP
}

output "AppB_IP" {
  value = module.compute.AppB_IP
}

output "AppC_IP" {
  value = module.compute.AppC_IP
}

output "vpc_id" {
  value       = module.network.vpc_id
  description = "The generated vpc id"
}