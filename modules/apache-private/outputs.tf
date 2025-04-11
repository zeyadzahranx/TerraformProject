output "apache_private_ids" {
  value = aws_instance.apache_private[*].id
}
output "instance_ids" {
  value = aws_instance.apache_private[*].id
}
