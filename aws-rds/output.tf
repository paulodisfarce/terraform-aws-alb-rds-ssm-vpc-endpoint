output "db_username_rds" {
  value = aws_db_instance.mysql_instance.username
}

output "db_instance_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}
