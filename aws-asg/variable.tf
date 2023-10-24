variable "subnet_private" {
  description = "The ID or name of the private subnet where your resources will be deployed."
}

variable "alb_target_group_arn" {
  description = "The Amazon Resource Name (ARN) of the Application Load Balancer (ALB) target group."
}

variable "SecurityGroup_template" {
  description = "The name or identifier of a security group template to be applied to the resources."
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling Group (ASG)."
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling Group (ASG)."
}

variable "desired_capacity" {
  description = "The desired number of instances in the Auto Scaling Group (ASG)."
}

variable "health_check_type" {
  description = "The type of health check to be used for monitoring the instances."
}
variable "health_check_grace_period" {
  description = "The time, in seconds, that AWS Auto Scaling waits before checking the health of instances after a scaling event."
}

#variable "termination_policies" {
 # description = "A comma-separated list of termination policies to be used when scaling down instances."
  #type        = string
#}

variable "name_asg" {
  description = "The name or identifier of the Auto Scaling Group (ASG)."
}
//Policy ASG UP
variable "nameUP" {}
variable "scaling_adjustmentUP" {}
variable "adjustment_typeUP" {}
variable "cooldownUP" {}
//Policy ASG Down
variable "nameDOWN" {}
variable "scaling_adjustmentDOWN" {}
variable "adjustment_typeDOWN" {}
variable "cooldownDOWN" {}


variable "instance_type" {
  description = "Type of Instance"
}
variable "name_template" {
  description = "name of Template"
}

variable "resource_type" {
  description = "type of resource from Template"
}
variable "instance_profile_name" {
  description = "Instance Profile Role for EC2"
}

variable "ec2_user_data" {
  description = "Install WebServer"
  type        = string
  default     = <<EOF
#!/bin/bash
sudo apt update
sudo apt-get install apache2 -y
sudo echo "<h1>Paulo H $(hostname -f)</h1>" > /var/www/html/index.html
EOF
}