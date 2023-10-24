

resource "aws_db_instance" "mysql_instance" {
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  //Username & Password for MYSQL
  username = var.username
  password = var.password

  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot

  vpc_security_group_ids = var.SecurityGroup_rds
  db_subnet_group_name   = var.subnet_db_group



  tags = {
    Name = "${terraform.workspace}-mydb"
  }
}