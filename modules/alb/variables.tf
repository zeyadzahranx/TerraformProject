variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal (private) or internet-facing"
  type        = bool
}

variable "subnet_ids" {
  description = "List of subnet IDs where the ALB should be deployed"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group to associate with the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}

variable "target_instance_ids" {
  description = "List of instance IDs to attach to the target group"
  type        = list(string)
}
