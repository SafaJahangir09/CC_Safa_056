output "frontend_public_ip" {
  value = module.frontend[*].public_ips[0]
}

output "backend_public_ips" {
  value = module.backend[*].public_ips
}

output "backend_private_ips" {
  value = module.backend[*].private_ips
}
