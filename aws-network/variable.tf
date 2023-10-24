variable "private_subnet" {
  type = map(string)
}

variable "public_subnet" {
  type = map(string)
}

variable "private_db_subnet" {
  type = map(string)
}
variable "cidr_world" {}
variable "cidr_vpc" {}
variable "protocol_sg" {}
variable "cidr_myip" {}
variable "name_vpc" {}
variable "name_sg_alb" {}
variable "name_sg_asg" {}
variable "description_sg_asg" {}
variable "description_sg_alb" {}
