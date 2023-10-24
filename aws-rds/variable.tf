variable "allocated_storage" {
  description = "The allocated storage in gibibytes for the RDS instance."
}

variable "storage_type" {
  description = "The storage type for the RDS instance (e.g., 'gp2', 'io1', 'standard')."
}

variable "engine" {
  description = "The database engine for the RDS instance (e.g., 'mysql', 'postgresql', 'sqlserver')."
}

variable "engine_version" {
  description = "The version of the database engine to use for the RDS instance."
}

variable "instance_class" {
  description = "The instance class (e.g., 'db.t2.micro', 'db.m4.large') for the RDS instance."
}

variable "name" {
  description = "The name of the RDS instance."
}

variable "username" {
  description = "The username for accessing the RDS instance."
}

variable "password" {
  description = "The password for the RDS instance's master user."
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with the RDS instance."
}

variable "skip_final_snapshot" {
  description = "Indicates whether a final DB snapshot should be created when the RDS instance is deleted."
}

variable "SecurityGroup_rds" {
  description = "The security group(s) to associate with the RDS instance."
}

variable "subnet_db_group" {
  description = "The subnet group where the RDS instance should be placed."
}