variable "subnets_ids" {
  type = list(string)
  description = "List of subnets identifiers for Application Load Balancer"
}

variable "target_group_vpc_id" {
  type = string
  description = "VPC identifier for Application Load Balancer target group"
}

variable "resource_prefix" {
  type = string
}
