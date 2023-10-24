data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}



module "aws-network" {
  source = "./aws-network"

  name_vpc   = "vpc-for-alb-asg"
  cidr_vpc   = "192.168.0.0/16"
  cidr_world = "0.0.0.0/0"

  //Public Subnet for ALB
  public_subnet = {
    us-east-1a = "192.168.11.0/24"
    us-east-1b = "192.168.12.0/24"
    us-east-1c = "192.168.13.0/24"
  }

  //Private Subnet for application
  private_subnet = {
    us-east-1a = "192.168.101.0/24"
    us-east-1b = "192.168.102.0/24"
    us-east-1c = "192.168.103.0/24"
  }

  //Private Subnet for RDSMySQL
  private_db_subnet = {
    us-east-1a = "192.168.201.0/24"
    us-east-1b = "192.168.202.0/24"
    us-east-1c = "192.168.203.0/24"
  }


  name_sg_alb        = "SecGroupALB"
  description_sg_alb = "Sec for ALB"

  name_sg_asg        = "SecGroupWEB"
  description_sg_asg = "Security for Application"

  protocol_sg = "tcp"

  cidr_myip = ["${chomp(data.http.myip.body)}/32"]


}

module "aws-rds" {
  source = "./aws-rds"

  allocated_storage = 20
  storage_type      = "gp2"

  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"

  name                 = "mydb"
  username             = "admin"
  password             = "mydbpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true


  SecurityGroup_rds = [module.aws-network.SecurityGroup_rds]
  subnet_db_group   = module.aws-network.subnet_db_group
}


module "aws-asg" {
  source = "./aws-asg"


  name_template    = "template-for-asg"
  instance_type    = "t2.small"
  key_name         = "aws-class-1"
  name_asg         = "asg-web-application"
  resource_type    = "instance"
  device_index     = 0
  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  //ASG Policy UP
  nameUP               = "web_policy_up"
  scaling_adjustmentUP = 1
  adjustment_typeUP    = "ChangeInCapacity"
  cooldownUP           = 300

  //ASG Policy DOWN
  nameDOWN               = "web_policy_down"
  scaling_adjustmentDOWN = -1
  adjustment_typeDOWN    = "ChangeInCapacity"
  cooldownDOWN           = 300

  health_check_type         = "EC2"
  health_check_grace_period = 300

  termination_policies   = ["Default"]
  instance_profile_name  = module.aws-SessionManager.instance_profile_name
  SecurityGroup_template = module.aws-network.SecurityGroup_template
  subnet_public          = module.aws-network.subnet_public
  subnet_private         = module.aws-network.subnet_private
  alb_target_group_arn   = module.aws-alb.alb_target_group_arn

}

module "aws-cloudwatch" {
  source = "./aws-cloudwatch"

  //UP
  alarm_nameUP          = "web_cpu_alarm_up"
  comparison_operatorUP = "GreaterThanOrEqualToThreshold"
  evaluation_periodsUP  = "2"
  metric_nameUP         = "CPUUtilization"
  namespaceUP           = "AWS/EC2"
  periodUP              = "120"
  statisticUP           = "Average"
  thresholdUP           = "70"
  alarm_descriptionUP   = "This metric monitor EC2 instance CPU utilization for UP"

  //DOWN
  alarm_nameDOWN          = "web_cpu_alarm_down"
  comparison_operatorDOWN = "LessThanOrEqualToThreshold"
  evaluation_periodsDOWN  = "2"
  metric_nameDOWN         = "CPUUtilization"
  namespaceDOWN           = "AWS/EC2"
  periodDOWN              = "120"
  statisticDOWN           = "Average"
  thresholdDOWN           = "30"
  alarm_descriptionDOWN   = "This metric monitor EC2 instance CPU utilization for DOWN"

  asg_policy_up   = [module.aws-asg.asg_policy_up]
  asg_policy_down = [module.aws-asg.asg_policy_down]
  asg_group_name  = module.aws-asg.asg_group_name
}

module "aws-alb" {
  source = "./aws-alb"

  name_alb                   = "public-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  port                       = 80
  protocol                   = "HTTP"
  type                       = "forward"
  path                       = "/"
  matcher                    = "200"
  enable_deletion_protection = false
  template_launcher          = module.aws-asg.template_launcher

  vpc_id            = module.aws-network.vpc_id
  subnet_public     = module.aws-network.subnet_public
  SecurityGroup_alb = [module.aws-network.SecurityGroup_alb]
}

module "aws-SessionManager" {
  source = "./aws-SessionManager"

  name = "EC2SSMRole_TF"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  name_profile = "Instance_SSM_Profile"

}