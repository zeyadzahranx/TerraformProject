# ─────────────────────────────────────────────────────────
# network module: main.tf (create VPC, subnets, IGW, NAT Gateway, route tables)
# ─────────────────────────────────────────────────────────

# Create VPC
resource "aws_vpc" "zeyad_s_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Create public subnets
resource "aws_subnet" "zeyad_s_public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.zeyad_s_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-%d", var.public_subnet_name_prefix, count.index + 1)
  }
}

# Create private subnets
resource "aws_subnet" "zeyad_s_private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.zeyad_s_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = format("%s-%d", var.private_subnet_name_prefix, count.index + 1)
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "zeyad_s_igw" {
  vpc_id = aws_vpc.zeyad_s_vpc.id

  tags = {
    Name = "zeyad-s-igw"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Create NAT Gateway in first public subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.zeyad_s_public_subnets[0].id

  tags = {
    Name = "zeyad-s-nat-gw"
  }
}

# Create public route table
resource "aws_route_table" "zeyad_s_public_route_table" {
  vpc_id = aws_vpc.zeyad_s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zeyad_s_igw.id
  }

  tags = {
    Name = "zeyad-s-public-route-table"
  }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.zeyad_s_public_subnets)
  subnet_id      = aws_subnet.zeyad_s_public_subnets[count.index].id
  route_table_id = aws_route_table.zeyad_s_public_route_table.id
}

# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.zeyad_s_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "zeyad-s-private-route-table"
  }
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.zeyad_s_private_subnets)
  subnet_id      = aws_subnet.zeyad_s_private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a security group to be reused
resource "aws_security_group" "zeyad_s_sg" {
  name        = "zeyad-s-sg"
  description = "Allow SSH, HTTP"
  vpc_id      = aws_vpc.zeyad_s_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zeyad-s-sg"
  }
}

