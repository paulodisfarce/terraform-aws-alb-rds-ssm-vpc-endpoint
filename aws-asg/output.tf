output "asg_policy_up" {
  value = aws_autoscaling_policy.asg_policy_up.arn
}

output "asg_policy_down" {
  value = aws_autoscaling_policy.asg_policy_down.arn
}

output "asg_group_name" {
  value = aws_autoscaling_group.main.name
}

output "template_launcher" {
  value = aws_launch_template.this.id
}
