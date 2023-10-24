variable "private_subnet" {
  description = "CIDR for private Subnet"
  type        = map(string)
}

variable "public_subnet" {
  description = "CIDR for Public Subnet"
  type        = map(string)
}

variable "private_db_subnet" {
  description = "CIDR for Private DB Subnet"
  type        = map(string)
}
variable "cidr_world" {
  description = "CIDR for WORLD"
}
variable "cidr_vpc" {
  description = "CIDR for VPC"
}

variable "name_sg_alb" {
  description = "name for Security Group from Load Balancer"
}
variable "name_sg_asg" {
  description = "name for Security Group from Template Auto-scaling"
}
variable "name_sg_db" {
  description = "name for Security Group from Database"
}
variable "description_sg_db" {
  description = "description for Security Group from Database"
}
variable "description_sg_asg" {
  description = "description for Security Group from Template Auto-scaling"
}
variable "description_sg_alb" {
  description = "description for Security Group from from Load Balancer"
}

