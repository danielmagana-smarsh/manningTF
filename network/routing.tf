# IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name  = "IGW - DM"
    Owner = "DM"
  }
}

# NAT GWs and EIPs
resource "aws_eip" "EipForNatGwA" {
  vpc = true

  tags = {
    Name  = "NatGwA EIP - DM"
    Owner = "DM"
  }
}

resource "aws_eip" "EipForNatGwB" {
  vpc = true

  tags = {
    Name  = "NatGwB EIP - DM"
    Owner = "DM"
  }
}

resource "aws_eip" "EipForNatGwC" {
  vpc = true

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

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name  = "Public RT - DM"
    Owner = "DM"
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
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwA.id
  }

  tags = {
    Name  = "Private RT A - DM"
    Owner = "DM"
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

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwB.id
  }

  tags = {
    Name  = "Private RT B - DM"
    Owner = "DM"
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

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGwC.id
  }

  tags = {
    Name  = "Private RT C - DM"
    Owner = "DM"
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
