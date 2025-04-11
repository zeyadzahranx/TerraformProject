#from network module
vpc_name                   = "zeyad-s-vpc"
vpc_cidr                   = "10.0.0.0/16"
azs                        = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs       = ["10.0.3.0/24", "10.0.4.0/24"]
igw_name                   = "zeyad-s-igw"
public_route_table_name    = "zeyad-s-public-route-table"
private_subnet_name_prefix = "zeyad-s-private-subnet"
public_subnet_name_prefix  = "zeyad-s-public-subnet"
#from nginx-proxy module
key_name         = "TerraKey"
private_key_path = "~/.ssh/TerraKey.pem"
