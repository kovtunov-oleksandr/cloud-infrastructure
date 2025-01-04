resource "aws_subnet" "private" {
  count             = length(var.subnets.private)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets.private[count.index].cidr_block
  availability_zone = var.subnets.private[count.index].availability_zone

  tags = merge(var.tags, {
    Name        = "${var.environment}-private-${count.index + 1}"
    Type        = "private"
  })
}

resource "aws_subnet" "public" {
  count                   = length(var.subnets.public)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnets.public[count.index].cidr_block
  availability_zone       = var.subnets.public[count.index].availability_zone
  map_public_ip_on_launch = var.subnets.public[count.index].map_public_ip_on_launch

  tags = merge(var.tags, {
    Name        = "${var.environment}-public-${count.index + 1}"
    Type        = "public"
  })
}
