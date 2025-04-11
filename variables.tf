# from network module
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

# shared module variables
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instance_name_prefix" {
  description = "Prefix for naming EC2 instances"
  type        = string
  default     = "zeyad-s-nginx-proxy"
}

variable "key_name" {
  description = "Name of the AWS key pair to SSH into instances"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file for remote-exec"
  type        = string
}
