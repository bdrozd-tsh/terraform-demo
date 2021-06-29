locals {
  resource_prefix = join("-", [var.service_name, var.service_stage])
}

module "log_group" {
  source = "../modules/cloudwatch"

  resource_prefix = local.resource_prefix
}

module "vpc" {
  source = "../modules/vpc"
}

module "subnet" {
  source = "../modules/subnet"

  aws_availability_zones = var.aws_availability_zones
}

module "application_load_balancer" {
  source = "../modules/alb"

  subnets_ids         = module.subnet.subnets_ids
  target_group_vpc_id = module.vpc.vpc_id
  resource_prefix     = local.resource_prefix
}

module "rds" {
  source = "../modules/rds"

  ecs_security_group_ids = [module.ecs_service_api.api_security_group_id]
  resource_prefix        = local.resource_prefix
  rds_port               = 5432
  rds_username           = var.rds_username
  rds_password           = var.rds_password
  rds_db_name            = var.rds_db_name
}

module "redis" {
  source = "../modules/redis"

  resource_prefix        = local.resource_prefix
  redis_port             = 6379
  ecs_security_group_ids = [module.ecs_service_api.api_security_group_id]
}

module "ecs_cluster" {
  source = "../modules/ecs/cluster"

  resource_prefix = local.resource_prefix
}

module "ecs_service_api" {
  source = "../modules/ecs/service/api"

  memory                            = 512
  cpu                               = 256
  container_port                    = 1337
  host_port                         = 1337
  cluster_id                        = module.ecs_cluster.id
  api_docker_image                  = var.api_docker_image
  desired_containers_count          = length(module.subnet.subnets_ids)
  subnets_ids                       = module.subnet.subnets_ids
  load_balancer_target_group_arn    = module.application_load_balancer.alb_target_group_arn
  load_balancer_security_groups_ids = [module.application_load_balancer.alb_security_group_id]
  resource_prefix                   = local.resource_prefix
  aws_region                        = var.aws_region
  rds_hostname                      = module.rds.rds_hostname
  rds_db_name                       = var.rds_db_name
  rds_port                          = 5432
  rds_username                      = var.rds_username
  rds_password                      = var.rds_password
  redis_url                         = module.redis.redis_url
  app_name                          = var.app_name
  app_stage                         = var.app_stage
  logs_group_name                   = module.log_group.log_group_name
}
