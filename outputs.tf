output "vpc_arn" {
  value = aws_vpc.main.arn
}
output "vpc_tags" {
  value = aws_vpc.main.tags
}
# print the subnet id's 
output "pub_subnet_ids" {
  value = aws_subnet.main.*.id
}