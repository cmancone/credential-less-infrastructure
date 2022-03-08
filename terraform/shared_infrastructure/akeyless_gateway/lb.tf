resource "aws_lb" "gateway" {
  name                             = var.name
  internal                         = false
  enable_cross_zone_load_balancing = true
  idle_timeout                     = "60"
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb.id]
  subnets                          = var.public_subnet_ids
  enable_deletion_protection       = false
  tags                             = var.tags

  access_logs {
    bucket = (var.alb_access_logs_bucket_name != null && var.alb_access_logs_bucket_name != "") ? var.alb_access_logs_bucket_name : null
  }
}

module "lb_listener" {
  source = "./lb_listener"

  for_each                    = var.gateway_ports
  name                        = var.name
  vpc_id                      = var.vpc_id
  load_balancer_arn           = aws_lb.gateway.arn
  internet_port               = each.key
  container_port              = each.value
  certificate_arn             = aws_acm_certificate_validation.cert_validation.certificate_arn
  ssl_policy                  = var.ssl_policy
  lb_security_group_id        = aws_security_group.lb.id
  ecs_tasks_security_group_id = aws_security_group.ecs_tasks.id
}

resource "aws_security_group" "lb" {
  name        = var.name
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
