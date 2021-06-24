output "redis_hostname" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.address
}

output "redis_port" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.port
}

output "redis_url" {
  value = join("", ["redis://", aws_elasticache_cluster.redis.cache_nodes.0.address, ":", aws_elasticache_cluster.redis.cache_nodes.0.port, "/1"])
}
