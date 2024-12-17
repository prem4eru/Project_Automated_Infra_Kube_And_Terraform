# Output for VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

# Output for Public Subnet ID
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

# Output for Private Subnet ID
output "private_subnet_id" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

# Output for Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output for NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gw.id
}
