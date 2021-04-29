# VPC 
resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name  = "VPC - DM"
    Owner = "DM"
  }
}

# Subnets 
resource "aws_subnet" "PublicSubnetA" {
  cidr_block              = var.publicA_subnet_cidr_block
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = var.az1a
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "PublicSubnetB" {
  cidr_block              = var.publicB_subnet_cidr_block
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = var.az1b
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "PublicSubnetC" {
  cidr_block              = var.publicC_subnet_cidr_block
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = var.az1c
  map_public_ip_on_launch = true

  tags = {
    Name  = "Public Subnet C - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppA" {
  cidr_block        = var.appA_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1a

  tags = {
    Name  = "App Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppB" {
  cidr_block        = var.appB_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1b

  tags = {
    Name  = "App Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "AppC" {
  cidr_block        = var.appC_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1c

  tags = {
    Name  = "App Subnet C - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbA" {
  cidr_block        = var.dbA_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1a

  tags = {
    Name  = "DB Subnet A - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbB" {
  cidr_block        = var.dbB_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1b

  tags = {
    Name  = "DB Subnet B - DM"
    Owner = "DM"
  }
}

resource "aws_subnet" "DbC" {
  cidr_block        = var.dbC_subnet_cidr_block
  vpc_id            = aws_vpc.VPC.id
  availability_zone = var.az1c

  tags = {
    Name  = "DB Subnet C - DM"
    Owner = "DM"
  }
}
