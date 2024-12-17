# Main VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[0] # Corrected availability_zone reference

  tags = {
    Name = "${var.environment}-public-subnet"
  }
}

# Private Subnets
#resource "aws_subnet" "private_subnet" {
 # for_each = toset(var.private_subnet_cidr) # Ensures private_subnet_cidr is a map
 # vpc_id                  = aws_vpc.main_vpc.id
 #cidr_block              = each.value
 # availability_zone       = var.availability_zones[each.key]
 #map_public_ip_on_launch = false

 # tags = {
  #  Name = "${var.environment}-private-subnet-${each.value}"
  ##}
#}





# Private Subnets
resource "aws_subnet" "private_subnet" {
  for_each = zipmap(var.availability_zones, var.private_subnet_cidr) # Zipping the AZs and CIDRs together
  
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-private-subnet-${each.value}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.environment}-nat-gateway"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_rt_assoc" {
  for_each      = aws_subnet.private_subnet
  subnet_id     = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
