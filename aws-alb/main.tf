//Load Balancer
resource "aws_lb" "alb" {
  name                       = "${var.name_alb}-${terraform.workspace}"
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.SecurityGroup_alb
  subnets                    = var.subnet_public
  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    name = "${var.name_alb}-${terraform.workspace}"
  }
}

resource "aws_lb_target_group" "alb_target_group_arn" {
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path    = var.path
    matcher = var.matcher
  }

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.alb_target_group_arn.arn
  }
}


