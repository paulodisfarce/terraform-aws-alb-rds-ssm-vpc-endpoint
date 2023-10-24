output "SecurityGroup_alb" {
  value = aws_security_group.sg-alb.id
}

output "SecurityGroup_template" {
  value = aws_security_group.sg-asg.id
}

output "subnet_private" {
  value = aws_subnet.private.*.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_public" {
  value = aws_subnet.public.*.id
}

output "SecurityGroup_rds" {
  value = aws_security_group.sg-db.id
}

output "subnet_db_group" {
  value = aws_db_subnet_group.private_db_group.id
}

output "subnet_bastion" {
  value = aws_subnet.public[0].id
}

