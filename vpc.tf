#Custom VPC

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "CustomVPC"
  }

}

#AWS Subnet
resource "aws_subnet" "public_subnet_main-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "PubSub-1"
  }
}

resource "aws_subnet" "public_subnet_main-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "PubSub-2"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyIGW"
  }
}

#Route Table

resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "PublicRouteTab"
  }
}

#Route Table Associate Public
resource "aws_route_table_association" "Public_Route-1" {
  subnet_id      = aws_subnet.public_subnet_main-1.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_route_table_association" "Public_Route-2" {
  subnet_id      = aws_subnet.public_subnet_main-2.id
  route_table_id = aws_route_table.RouteTable.id
}

