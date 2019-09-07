resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = "main_vpc"
    Creator = "backend"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name    = "public_subnet_a"
    Creator = "backend"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name    = "private_subnet_a"
    Creator = "backend"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name    = "private_subnet_b"
    Creator = "backend"
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "main_gw"
    Creator = "backend"
  }
}

resource "aws_route_table" "main_route_table" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_gw.id}"
  }
  tags = {
    Name = "main_route_table"
    Creator = "backend"
  }
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.main_route_table.id}"
}
