# VPC and IGW
resource "aws_vpc" "VPC" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name  = "VPC - DM"
    Owner = "DM"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name  = "IGW - DM"
    Owner = "DM"
  }
}

# Subnets 
resource "aws_subnet" "PublicSubnetA" {
  cidr_block              = "172.16.1.0/24"
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "PublicSubnetB" {
  cidr_block              = "172.16.2.0/24"
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "PublicSubnetC" {
  cidr_block              = "172.16.3.0/24"
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet C - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppA" {
  cidr_block        = "172.16.4.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2a"

  tags = {
    Name  = "App Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppB" {
  cidr_block        = "172.16.5.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2b"

  tags = {
    Name  = "App Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppC" {
  cidr_block        = "172.16.6.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2c"

  tags = {
    Name  = "App Subnet C - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbA" {
  cidr_block        = "172.16.8.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2a"

  tags = {
    Name  = "DB Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbB" {
  cidr_block        = "172.16.9.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2b"

  tags = {
    Name  = "DB Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbC" {
  cidr_block        = "172.16.10.0/24"
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-west-2c"

  tags = {
    Name  = "DB Subnet C - DM"
    Owner = "DM"
  }
}

# NAT GWs and EIPs
resource "aws_eip" "EipForNatGwA" {
  tags = {
    Name  = "NatGwA EIP - DM"
    Owner = "DM"
  }
}

resource "aws_eip" "EipForNatGwB" {
  tags = {
    Name  = "NatGwB EIP - DM"
    Owner = "DM"
  }
}

resource "aws_eip" "EipForNatGwC" {
  tags = {
    Name  = "NatGwC EIP - DM"
    Owner = "DM"
  }
}

resource "aws_nat_gateway" "NatGwA" {
  allocation_id = aws_eip.EipForNatGwA.id
  subnet_id     = aws_subnet.PublicSubnetA.id

  tags = {
    Name  = "NatGwA - DM"
    Owner = "DM"
  }
}

resource "aws_nat_gateway" "NatGwB" {
  allocation_id = aws_eip.EipForNatGwB.id
  subnet_id     = aws_subnet.PublicSubnetB.id

  tags = {
    Name  = "NatGwB - DM"
    Owner = "DM"
  }
}

resource "aws_nat_gateway" "NatGwC" {
  allocation_id = aws_eip.EipForNatGwC.id
  subnet_id     = aws_subnet.PublicSubnetC.id

  tags = {
    Name  = "NatGwC - DM"
    Owner = "DM"
  }
}

# Route tables 
resource "aws_route_table" "RouteTablePublic" {
  vpc_id = aws_vpc.VPC.id
  # depends_on = [aws_internet_gateway.IGW]

  tags = {
    Name  = "Public RT - DM"
    Owner = "DM"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublicA" {
  subnet_id      = aws_subnet.PublicSubnetA.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "AssociationForRouteTablePublicB" {
  subnet_id      = aws_subnet.PublicSubnetB.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "AssociationForRouteTablePublicC" {
  subnet_id      = aws_subnet.PublicSubnetC.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table" "RouteTablePrivateA" {
  vpc_id     = aws_vpc.VPC.id
  depends_on = [aws_nat_gateway.NatGwA]

  tags = {
    Name  = "Private RT A - DM"
    Owner = "DM"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwA.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivateA_App" {
  subnet_id      = aws_subnet.AppA.id
  route_table_id = aws_route_table.RouteTablePrivateA.id
}

resource "aws_route_table_association" "AssociationForRouteTablePrivateA_DB" {
  subnet_id      = aws_subnet.DbA.id
  route_table_id = aws_route_table.RouteTablePrivateA.id
}

resource "aws_route_table" "RouteTablePrivateB" {
  vpc_id     = aws_vpc.VPC.id
  depends_on = [aws_nat_gateway.NatGwB]

  tags = {
    Name  = "Private RT B - DM"
    Owner = "DM"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwB.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivateB_App" {
  subnet_id      = aws_subnet.AppB.id
  route_table_id = aws_route_table.RouteTablePrivateB.id
}

resource "aws_route_table_association" "AssociationForRouteTablePrivateB_DB" {
  subnet_id      = aws_subnet.DbB.id
  route_table_id = aws_route_table.RouteTablePrivateB.id
}

resource "aws_route_table" "RouteTablePrivateC" {
  vpc_id     = aws_vpc.VPC.id
  depends_on = [aws_nat_gateway.NatGwC]

  tags = {
    Name  = "Private RT C - DM"
    Owner = "DM"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwC.id
  }

}

resource "aws_route_table_association" "AssociationForRouteTablePrivateC_App" {
  subnet_id      = aws_subnet.AppC.id
  route_table_id = aws_route_table.RouteTablePrivateC.id
}

resource "aws_route_table_association" "AssociationForRouteTablePrivateC_DB" {
  subnet_id      = aws_subnet.DbC.id
  route_table_id = aws_route_table.RouteTablePrivateC.id
}