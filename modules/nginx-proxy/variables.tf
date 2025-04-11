variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to launch EC2 instances into"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to assign to EC2 instances"
  type        = string
}

variable "instance_name_prefix" {
  description = "Prefix for naming Nginx proxy instances"
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
