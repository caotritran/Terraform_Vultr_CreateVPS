output "PublicIP" {
  description = "The IP is:"
  value       = vultr_instance.new_instance.main_ip
}

output "password" {
  description = "The password is:"
  value       = random_string.random.*.result
}