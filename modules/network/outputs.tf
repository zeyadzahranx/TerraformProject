output "vpc_id" {
  value = aws_vpc.zeyad_s_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.zeyad_s_public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.zeyad_s_private_subnets[*].id
}

output "security_group_id" {
  value = aws_security_group.zeyad_s_sg.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}

output "nat_eip" {
  value = aws_eip.nat_eip.public_ip
}
