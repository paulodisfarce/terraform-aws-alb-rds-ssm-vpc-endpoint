//Inbound and Outbound for Security Group
locals {
  inbound_rules_alb = [
    { port = 80, description = "port HTTP", protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  outbound_rules_alb = [
    { port = 80, description = "port HTTP", protocol = "tcp", cidr_blocks = flatten([aws_subnet.private_db_subnet.*.cidr_block]) }
  ]
  inbound_rules_app = [
    { port = 443, description = "port 80", protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { port = 80, description = "port HTTP", protocol = "tcp", cidr_blocks = flatten([aws_subnet.public.*.cidr_block]) },
    { port = 3306, description = "port MYSQL", protocol = "tcp", cidr_blocks = flatten([aws_subnet.private_db_subnet.*.cidr_block]) },
    #{ port = 22, description = "port for SSH", protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] } #179.108.28.17/32
  ]
  outbound_rules_app = [
    { port = 80, description = "port 80", protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { port = 443, description = "port 80", protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { port = 3306, description = "port 3306", protocol = "tcp", cidr_blocks = flatten([aws_subnet.private_db_subnet.*.cidr_block]) },
    #{ port = 22, description = "port 22", protocol = "tcp", cidr_blocks = flatten([aws_subnet.private.*.cidr_block]) },
  ]
  inbound_rules_db = [
    { port = 3306, description = "port 3306", protocol = "tcp", cidr_blocks = flatten([aws_subnet.private.*.cidr_block]) }
  ]
}


#resource "aws_ec2_instance_connect_endpoint" "example" {
 # subnet_id          = flatten(aws_subnet.private.*.id)[0]
  #security_group_ids = [aws_security_group.sg-asg.id]
 # preserve_client_ip = false
#}

//SG for ALB
resource "aws_security_group" "sg-alb" {
  vpc_id      = aws_vpc.main.id
  name        = var.name_sg_alb
  description = var.description_sg_alb
  dynamic "ingress" {
    for_each = local.inbound_rules_alb
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = local.outbound_rules_alb
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = aws_subnet.private.*.cidr_block
    }
  }
    tags = {
    name = "${terraform.workspace}-SecGroupALB"
  }
}

//SG for ASG/Template
resource "aws_security_group" "sg-asg" {
  vpc_id      = aws_vpc.main.id
  name        = var.name_sg_asg
  description = var.description_sg_asg
  dynamic "ingress" {
    for_each = local.inbound_rules_app
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = local.outbound_rules_app
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
    tags = {
    name = "${terraform.workspace}-SecGroupASG"
  }
}

//SG for DB
resource "aws_security_group" "sg-db" {
  vpc_id      = aws_vpc.main.id
  name        = "SecGroupDB"
  description = "Security Group for Database"
  dynamic "ingress" {
    for_each = local.inbound_rules_db
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = aws_subnet.private.*.cidr_block
    }
  }
  tags = {
    name = "${terraform.workspace}-SecGroupDB"
  }
}



