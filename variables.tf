variable "aws_region" {
  type = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}

variable "aws_availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "application_docker_image" {
  type        = string
  description = "Application docker image uri and tag in format <uri>:<tag>"
}

variable "app_prefix" {
  type        = string
  description = "Application prefix. Typically a username. All AWS resources will be prefixed using this value"
}

variable "app_name" {
  type        = string
  description = "Application name. All AWS resources will contain this value"
}
