output "alb_target_group_arn" {
  value = aws_lb_target_group.lb_target_group.arn
}

output "alb_groups_id" {
  value = aws_security_group.load_balancer_security_group.id
}
