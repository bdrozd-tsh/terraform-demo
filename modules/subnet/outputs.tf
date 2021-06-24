output "subnets_ids" {
  value = aws_default_subnet.default_subnets.*.id
}
