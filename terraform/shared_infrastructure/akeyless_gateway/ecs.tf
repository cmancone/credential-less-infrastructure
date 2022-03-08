resource "aws_ecs_cluster" "gateway" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = true
  }

  tags = var.tags
}

resource "aws_ecs_service" "gateway" {
  name                   = var.name
  cluster                = aws_ecs_cluster.gateway.id
  task_definition        = aws_ecs_task_definition.gateway.arn
  desired_count          = var.desired_task_count
  platform_version       = "1.4.0"
  launch_type            = "FARGATE"
  enable_execute_command = true

  depends_on = [aws_lb.gateway]

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  dynamic "load_balancer" {
    for_each = module.lb_listener[*]
    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = var.name
      container_port   = load_balancer.value["container_port"]
    }
  }

  tags = var.tags
}

data "template_file" "container_definitions" {
  template = file("${path.module}/task_definition.json")

  vars = {
    name               = var.name
    region             = var.region
    domain_name        = var.domain_name
    admin_access_id    = var.admin_access_id
    allowed_access_ids = var.allowed_access_ids
  }
}

resource "aws_ecs_task_definition" "gateway" {
  family                   = var.name
  container_definitions    = data.template_file.container_definitions.rendered
  execution_role_arn       = var.iam_role_arn
  task_role_arn            = var.iam_role_arn
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "512"
  requires_compatibilities = ["FARGATE"]

  volume {
    name = "config-storage"
  }
  volume {
    name = "log-storage"
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "gateway" {
  name              = "/app/${var.name}"
  retention_in_days = "30"

  tags = merge(var.tags, {
    "Name" = var.name
  })
}

# incoming rules to allow traffic from the load balancer to the tasks are set in
# ./lb_listener/main.tf
resource "aws_security_group" "ecs_tasks" {
  name        = var.name
  description = "Security group for the ${var.name} ECS Tasks"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ecs_tasks_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_tasks.id
}
