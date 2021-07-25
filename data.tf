# List of availabilty zones in current region
data "aws_availability_zones" "azs" {
  state = "available"
}