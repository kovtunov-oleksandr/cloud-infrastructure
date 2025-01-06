resource "aws_security_group" "main" {
  name        = "${var.environment}-sg"
  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all outbound traffic"
  }

  lifecycle {
    create_before_destroy = true                            # add lifecycle policy
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-sg"
  })
}
