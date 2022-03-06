resource "aws_ecs_cluster" "gateway" {
  name               = local.name
  capacity_providers = "FARGATE"
  tags               = local.tags
}

resource "aws_ecs_service" "mongo" {
  name            = local.name
  cluster         = aws_ecs_cluster.gateway.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 1
  iam_role        = var.gateway_iam_role_arn

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
