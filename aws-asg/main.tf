
// quantidade de EC2 min/max/desejada
resource "aws_autoscaling_group" "main" {
  name                = "${var.name_asg}-${terraform.workspace}"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  target_group_arns   = var.alb_target_group_arn
  vpc_zone_identifier = var.subnet_private
  //Conexão entre ASG e o Template
  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}


// Policy UP para ser usada no CloudWatch
resource "aws_autoscaling_policy" "asg_policy_up" {
  name                   = var.nameUP
  scaling_adjustment     = var.scaling_adjustmentUP
  adjustment_type        = var.adjustment_typeUP
  cooldown               = var.cooldownUP
  autoscaling_group_name = aws_autoscaling_group.main.name
}
// Policy DOWN para ser usada no CloudWatch
resource "aws_autoscaling_policy" "asg_policy_down" {
  name                   = var.nameDOWN
  scaling_adjustment     = var.scaling_adjustmentDOWN
  adjustment_type        = var.adjustment_typeDOWN
  cooldown               = var.cooldownDOWN
  autoscaling_group_name = aws_autoscaling_group.main.name
}