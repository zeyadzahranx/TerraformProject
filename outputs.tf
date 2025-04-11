output "nginx_proxy_ips" {
  value = module.nginx_proxy.nginx_proxy_public_ips
}

output "apache_private_instance_ids" {
  value = module.apache_private.apache_private_ids
}

output "public_alb_dns" {
  value = module.public_alb.alb_dns_name
}

output "private_alb_dns" {
  value = module.private_alb.alb_dns_name
}
