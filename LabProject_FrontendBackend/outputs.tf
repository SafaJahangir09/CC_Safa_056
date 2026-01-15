output "frontend_public_ip" {
  description = "Public IP of frontend (Nginx)"
  value       = aws_instance.frontend.public_ip
}

output "backend_public_ips" {
  description = "Public IPs of backend servers"
  value       = [for b in aws_instance.backend : b.public_ip]
}

output "backend_private_ips" {
  description = "Private IPs of backend servers"
  value       = [for b in aws_instance.backend : b.private_ip]
}

