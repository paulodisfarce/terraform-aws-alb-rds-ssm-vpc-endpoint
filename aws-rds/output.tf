
output "host-rds" {
  value = aws_db_instance.mysql_instance.address
}

output "username-rds" {
  value = aws_db_instance.mysql_instance.username
}

output "domain-rds" {
  value = aws_db_instance.mysql_instance.domain
}

output "db-rds" {
  value = aws_db_instance.mysql_instance.db_name
}