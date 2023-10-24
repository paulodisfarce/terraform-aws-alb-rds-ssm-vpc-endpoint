variable "SecurityGroup_alb" {
  description = "The security group(s) to associate with the Application Load Balancer (ALB)."
}

variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) where the ALB should be created."
}

variable "subnet_public" {
  description = "The public subnets where the ALB should be deployed."
}

variable "port" {
  description = "The port on which the ALB should listen for incoming traffic."
}

variable "protocol" {
  description = "The protocol used for routing traffic (e.g., 'HTTP', 'HTTPS')."
}

variable "type" {
  description = "The type of target group for routing traffic (e.g., 'target-group', 'ip')."
}

variable "enable_deletion_protection" {
  description = "Indicates whether deletion protection should be enabled for the ALB."
}

variable "internal" {
  description = "Specifies if the ALB should be internal (inside a VPC) or external (public)."
}

variable "load_balancer_type" {
  description = "The type of load balancer (e.g., 'application', 'network') to create."
}

variable "name_alb" {
  description = "The name of the Application Load Balancer (ALB)."
}

variable "matcher" {
  description = "The content-based routing rules for the ALB."
}

variable "path" {
  description = "The path pattern used for routing requests to the target group."
}

variable "template_launcher" {
  description = "The template launcher used for the ALB."
}