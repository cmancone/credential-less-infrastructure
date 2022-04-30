resource "aws_security_group" "gateway" {
  name        = "${var.name}-gateway"
  description = "Security group for gateway"
  vpc_id      = var.vpc_id
  tags = merge(var.tags, {
    "Name" = "${var.name}-gateway"
  })
}

resource "aws_security_group_rule" "gateway_outgoing" {
  security_group_id = aws_security_group.gateway.id
  description       = "Allow outgoing"
  type              = "egress"
  from_port         = 1
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "lb" {
  name        = "${var.name}-lb"
  description = "Security group for the ${var.name} ALB"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "lb_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb.id
}
