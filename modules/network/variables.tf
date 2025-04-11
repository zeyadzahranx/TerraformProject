variable "vpc_cidr" {}
variable "vpc_name" {}
variable "azs" {
  type = list(string)
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "public_subnet_name_prefix" {
  description = "Base name for public subnets"
  type        = string
}
variable "private_subnet_name_prefix" {
  description = "Base name for private subnets"
  type        = string
}
variable "public_route_table_name" {}
variable "igw_name" {}

