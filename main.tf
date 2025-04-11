
module "network" {
  source = "./modules/network"

  vpc_name                   = var.vpc_name
  vpc_cidr                   = var.vpc_cidr
  azs                        = var.azs
  public_subnet_cidrs        = var.public_subnet_cidrs
  private_subnet_cidrs       = var.private_subnet_cidrs
  igw_name                   = var.igw_name
  public_route_table_name    = var.public_route_table_name
  private_subnet_name_prefix = var.private_subnet_name_prefix
  public_subnet_name_prefix  = var.public_subnet_name_prefix
}

module "nginx_proxy" {
  source               = "./modules/nginx-proxy"
  instance_type        = "t2.micro"
  key_name             = var.key_name
  private_key_path     = var.private_key_path
  public_subnet_ids    = module.network.public_subnet_ids
  security_group_id    = module.network.security_group_id
  depends_on = [module.network]
  instance_name_prefix = "zeyad-s-nginx-proxy"
}

module "apache_private" {
  source               = "./modules/apache-private"
  instance_type        = "t2.micro"
  private_subnet_ids   = module.network.private_subnet_ids
  security_group_id    = module.network.security_group_id
  key_name             = "TerraKey"
  instance_name_prefix = "zeyad-s-apache"
}

# PUBLIC ALB in front of nginx proxies
module "public_alb" {
  source              = "./modules/alb"
  alb_name            = "zeyad-s-public-alb"
  internal            = false
  subnet_ids          = module.network.public_subnet_ids
  security_group_id   = module.network.security_group_id
  vpc_id              = module.network.vpc_id
  target_group_name   = "zeyad-s-nginx-tg"
  target_instance_ids = module.nginx_proxy.instance_ids
}

# PRIVATE ALB in front of apache private instances
module "private_alb" {
  source              = "./modules/alb"
  alb_name            = "zeyad-s-private-alb"
  internal            = true
  subnet_ids          = module.network.private_subnet_ids
  security_group_id   = module.network.security_group_id
  vpc_id              = module.network.vpc_id
  target_group_name   = "zeyad-s-apache-tg"
  target_instance_ids = module.apache_private.instance_ids
}
