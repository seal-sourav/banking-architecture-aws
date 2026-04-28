variable "project_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}