locals {
  tags     = merge(var.vpc_tags, { Name = "maruthi-3tier-${terraform.workspace}" })
  az_names = data.aws_availability_zones.azs.names
  az_count = length(local.az_names)
  pub_subnet_ids = aws_subnet.main.*.id
}