resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnets" {
  count             = length(var.aws_availability_zones)
  availability_zone = element(var.aws_availability_zones, count.index)
}

module "application_load_balancer" {
  source = "./modules/alb"

  subnets_ids         = aws_default_subnet.default_subnets.*.id
  target_group_vpc_id = aws_default_vpc.default_vpc.id
  resource_prefix     = "${var.app_prefix}-${var.app_name}"
}

module "ecs" {
  source = "./modules/ecs"

  memory                            = 512
  cpu                               = 256
  container_port                    = 3000
  host_port                         = 3000
  application_docker_image          = var.application_docker_image
  desired_containers_count          = length(aws_default_subnet.default_subnets)
  subnets_ids                       = aws_default_subnet.default_subnets.*.id
  load_balancer_target_group_arn    = module.application_load_balancer.alb_target_group_arn
  load_balancer_security_groups_ids = [module.application_load_balancer.alb_groups_id]
  resource_prefix                   = "${var.app_prefix}-${var.app_name}"
}


