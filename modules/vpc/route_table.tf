resource "aws_route_table" "private" {
  count = length(var.subnets.private)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-private-rt-${count.index + 1}"
    Type        = "private"
  })

  depends_on = [
    aws_nat_gateway.main
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-public-rt"
    Type        = "public"
  })

  depends_on = [
    aws_internet_gateway.main
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(var.subnets.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id

  depends_on = [
    aws_route_table.private,
    aws_subnet.private
  ]
}

resource "aws_route_table_association" "public" {
  count          = length(var.subnets.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_route_table.public,
    aws_subnet.public,
  ]
}
