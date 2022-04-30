resource "aws_lb" "gateway" {
  name                             = var.name
  internal                         = false
  enable_cross_zone_load_balancing = true
  idle_timeout                     = "60"
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.lb.id]
  subnets                          = var.public_subnet_ids
  enable_deletion_protection       = false
  tags                             = var.tags
}

module "lb_listener" {
  source = "./lb_listener"

  for_each                   = var.gateway_ports
  name                       = var.name
  gateway_instance_id        = aws_instance.gateway_instance.id
  vpc_id                     = var.vpc_id
  load_balancer_arn          = aws_lb.gateway.arn
  internet_port              = each.key
  container_port             = each.value
  certificate_arn            = aws_acm_certificate_validation.cert_validation.certificate_arn
  lb_security_group_id       = aws_security_group.lb.id
  instance_security_group_id = aws_security_group.gateway.id
  tags                       = var.tags
}

data "aws_route53_zone" "gateway" {
  name = var.route_53_hosted_zone_name
}

resource "aws_route53_record" "gateway" {
  zone_id = data.aws_route53_zone.gateway.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.gateway.dns_name
    zone_id                = aws_lb.gateway.zone_id
    evaluate_target_health = true
  }

  lifecycle {
    ignore_changes = [zone_id]
  }
}
