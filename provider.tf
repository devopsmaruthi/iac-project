# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
# s3 backend with locking -DynamoDB
terraform {
  backend "s3" {
    bucket = "sdmj55"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "javahome-iac"
  }
}
# create a VPC with default tenancy
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = local.tags
}
# availability zones in current region
data "aws_availability_zones" "azs" {
  state = "available"
}
# create a subnet
resource "aws_subnet" "main" {
  count      = local.az_count
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index)
  tags = local.tags
  availability_zone = local.az_names[count.index]
}
# create a Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw-${terraform.workspace}"
  }
}
# create a route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  
  }
  tags = {
    Name = "public-rt-${terraform.workspace}"
  }
}
# Attach the route table to public subnet
resource "aws_route_table_association" "a" {
  count = length(local.pub_subnet_ids)
  subnet_id      = local.pub_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}