variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}
variable "vpc_tags" {
  type = map(string)
  default = {
    Name       = "main"
    Location   = "Bangalore"
    Department = "HR"
  }
}

variable "tenancy" {
  default = "default"
}
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}