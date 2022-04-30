output "target_group_arn" {
  value = aws_lb_target_group.https.arn
}

output "internet_port" {
  value = var.internet_port
}

output "container_port" {
  value = var.container_port
}
