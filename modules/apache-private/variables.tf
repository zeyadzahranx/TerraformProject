variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "instance_name_prefix" {
  description = "Name prefix for Apache EC2 instances"
  type        = string
  default     = "zeyad-s-apache"
}
