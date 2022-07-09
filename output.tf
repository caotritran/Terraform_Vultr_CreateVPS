output "PublicIP" {
  description = "The IP is:"
  value       = vultr_instance.new_instance.main_ip
}

output "password" {
  description = "The password is:"
  value       = nonsensitive(vultr_instance.new_instance.default_password)
}
