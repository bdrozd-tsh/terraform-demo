resource "aws_default_subnet" "default_subnets" {
  count             = length(var.aws_availability_zones)
  availability_zone = element(var.aws_availability_zones, count.index)
}
