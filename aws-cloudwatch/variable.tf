variable "asg_policy_up" {
  description = "This variable represents the name or identifier of the Auto Scaling Group (ASG) policy for upscaling."
}

variable "asg_policy_down" {
  description = "This variable represents the name or identifier of the Auto Scaling Group (ASG) policy for downscaling."
}

variable "asg_group_name" {
  description = "Use this variable to specify the name or identifier of the Auto Scaling Group (ASG) to which policies will be applied."
}

variable "alarm_nameUP" {
  description = "This variable is used to specify the name of the alarm that will be created."
}

variable "comparison_operatorUP" {
  description = "Use this variable to set the comparison operator for the alarm's condition (e.g., 'GreaterThanOrEqualToThreshold')."
}

variable "evaluation_periodsUP" {
  description = "This variable defines the number of periods over which data is compared to the threshold for the alarm."
}

variable "metric_nameUP" {
  description = "Specify the name of the metric to be monitored using this variable."
}

variable "namespaceUP" {
  description = "This variable represents the namespace of the metric (e.g., 'AWS/EC2') to be monitored by the alarm."
}

variable "periodUP" {
  description = "Set the period of time in seconds over which the specified metric data is evaluated using this variable."
}

variable "statisticUP" {
  description = "Use this variable to specify the statistic to be applied to the metric data (e.g., 'Average')."
}

variable "thresholdUP" {
  description = "This variable determines the threshold value that, when crossed, triggers the alarm."
}


variable "alarm_nameDOWN" {
  description = "This variable is used to specify the name of the alarm that will be created for downscaling purposes."
}

variable "comparison_operatorDOWN" {
  description = "Use this variable to set the comparison operator for the downscaling alarm's condition (e.g., 'LessThanThreshold')."
}

variable "evaluation_periodsDOWN" {
  description = "This variable defines the number of periods over which data is compared to the threshold for the downscaling alarm."
}

variable "metric_nameDOWN" {
  description = "Specify the name of the metric to be monitored by the downscaling alarm."
}

variable "namespaceDOWN" {
  description = "This variable represents the namespace of the metric (e.g., 'AWS/EC2') to be monitored by the downscaling alarm."
}

variable "periodDOWN" {
  description = "Set the period of time in seconds over which the specified metric data is evaluated for the downscaling alarm."
}

variable "statisticDOWN" {
  description = "Use this variable to specify the statistic to be applied to the metric data for the downscaling alarm (e.g., 'Average')."
}

variable "thresholdDOWN" {
  description = "This variable determines the threshold value that, when crossed, triggers the downscaling alarm."
}

variable "alarm_descriptionUP" {
  description = "This variable can be used to provide an optional description for upscaling alarms."
}

variable "alarm_descriptionDOWN" {
  description = "This variable can be used to provide an optional description for downscaling alarms."
}