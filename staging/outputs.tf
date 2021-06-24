output "application_load_balancer_dns_name" {
  value = module.application_load_balancer.dns_name
}

output "redis_url" {
  value = module.redis.redis_url
}

output "rds_hostname" {
  value = module.rds.rds_hostname
}
