output "nginx_proxy_public_ips" {
  value = aws_instance.nginx_proxy[*].public_ip
}
output "instance_ids" {
  value = aws_instance.nginx_proxy[*].id
}
