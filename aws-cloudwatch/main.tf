resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = var.alarm_nameUP
  comparison_operator = var.comparison_operatorUP
  evaluation_periods  = var.evaluation_periodsUP
  metric_name         = var.metric_nameUP
  namespace           = var.namespaceUP
  period              = var.periodUP
  statistic           = var.statisticUP
  threshold           = var.thresholdUP
  dimensions = {
    AutoScalingGroupName = var.asg_group_name
  }
  alarm_description = var.alarm_descriptionUP
  alarm_actions     = var.asg_policy_up
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = var.alarm_nameDOWN
  comparison_operator = var.comparison_operatorDOWN
  evaluation_periods  = var.evaluation_periodsDOWN
  metric_name         = var.metric_nameDOWN
  namespace           = var.namespaceDOWN
  period              = var.periodDOWN
  statistic           = var.statisticDOWN
  threshold           = var.thresholdDOWN
  dimensions = {
    AutoScalingGroupName = var.asg_group_name
  }
  alarm_description = var.alarm_descriptionDOWN
  alarm_actions     = var.asg_policy_down
}