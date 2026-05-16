variable "launch_template_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}