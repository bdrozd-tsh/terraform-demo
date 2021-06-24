output "alb_target_group_arn" {
  value = aws_lb_target_group.alb.arn
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "dns_name" {
  value = aws_alb.alb.dns_name
}
