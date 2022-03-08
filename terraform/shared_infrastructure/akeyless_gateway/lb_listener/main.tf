resource "aws_lb_target_group" "http" {
  name        = "${var.name}-{$var.container_port}"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = merge(var.tags, {
    Name = "${var.name}-{$var.container_port}"
  })
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.internet_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }

  tags = merge(var.tags, {
    Name = "${var.name}-${var.container_port}"
  })
}

resource "aws_security_group_rule" "lb_inbound" {
  type              = "ingress"
  from_port         = var.internet_port
  to_port           = var.internet_port
  protocol          = "tcp"
  cidr_blocks       = var.security_group_allowed_cidr_blocks
  security_group_id = var.lb_security_group_id
}

resource "aws_security_group_rule" "lb_to_ecs" {
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = var.lb_security_group_id
  security_group_id        = var.ecs_tasks_security_group_id
}
