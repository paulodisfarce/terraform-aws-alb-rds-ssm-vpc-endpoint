output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group_arn.*.arn
}

output "alb-dns" {
  value = aws_lb.alb.dns_name
}
