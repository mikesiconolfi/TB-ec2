###########################################
############ VPC Config ###################
###########################################
resource "aws_vpc" "vpc" {
  cidr_block           = "10.21.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name        = "Testvpc"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}
###########################################
############ Subnet Config ################
###########################################
resource "aws_subnet" "privatesubnet1b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.21.3.0/24"

  tags = {
    Name        = "Private Subnet 1b"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_subnet" "privatesubnet1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.21.1.0/24"

  tags = {
    Name        = "Private Subnet 1a"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_subnet" "publicsubnet1b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.21.2.0/24"

  tags = {
    Name        = "Public Subnet 1b"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_subnet" "publicsubnet1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.21.0.0/24"

  tags = {
    Name        = "Public Subnet 1a"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}
###########################################
############ Route Table Config ###########
###########################################
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name        = "Private RT"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "Public RT"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_route_table_association" "private1a" {
  subnet_id      = aws_subnet.privatesubnet1a.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "private1b" {
  subnet_id      = aws_subnet.privatesubnet1b.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "public1a" {
  subnet_id      = aws_subnet.publicsubnet1a.id
  route_table_id = aws_route_table.publicrt.id
}
resource "aws_route_table_association" "public1b" {
  subnet_id      = aws_subnet.publicsubnet1b.id
  route_table_id = aws_route_table.publicrt.id
}

###########################################
############## IGW Config #################
###########################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}
###########################################
############## NAT Config #################
###########################################
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.publicsubnet1a.id

  tags = {
    Name        = "NAT GW"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}
resource "aws_eip" "nat-eip" {
  vpc               = true

  tags = {
    Name        = "NAT EIP"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}