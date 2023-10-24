resource "aws_vpc" "main" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "${var.name_vpc}-${terraform.workspace}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_subnet)
  cidr_block              = element(values(var.private_subnet), count.index)
  availability_zone       = element(keys(var.private_subnet), count.index)
  map_public_ip_on_launch = false
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet)
  cidr_block              = element(values(var.public_subnet), count.index)
  availability_zone       = element(keys(var.public_subnet), count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_db_subnet" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_db_subnet)
  cidr_block              = element(values(var.private_db_subnet), count.index)
  availability_zone       = element(keys(var.private_db_subnet), count.index)
  map_public_ip_on_launch = false
}

resource "aws_db_subnet_group" "private_db_group" {
  name       = "db subnet group private"
  subnet_ids = aws_subnet.private_db_subnet.*.id
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_eip" "elastic_ip" {
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.elastic_ip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public[0].id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private_route_db_table" {
  vpc_id = aws_vpc.main.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rt_db_assoc" {
  count          = length(var.private_db_subnet)
  subnet_id      = element(aws_subnet.private_db_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route_db_table.id
}

