variable "name" {
  description = "The name of the SSM role."
}

variable "policy_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM policy to attach to the SSM role."
}

variable "name_profile" {
  description = "The name of the instance profile associated with the SSM role."
}