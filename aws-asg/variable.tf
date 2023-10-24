variable "subnet_private" {}
variable "alb_target_group_arn" {}
variable "SecurityGroup_template" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "health_check_type" {}
variable "health_check_grace_period" {}
variable "termination_policies" {}
variable "name_asg" {}
variable "nameUP" {}
variable "scaling_adjustmentUP" {}
variable "adjustment_typeUP" {}
variable "cooldownUP" {}
variable "nameDOWN" {}
variable "scaling_adjustmentDOWN" {}
variable "adjustment_typeDOWN" {}
variable "cooldownDOWN" {}
variable "instance_type" {}
variable "name_template" {}
variable "key_name" {}
variable "subnet_public" {}
variable "device_index" {}
variable "resource_type" {}
variable "instance_profile_name" {}

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