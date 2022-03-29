resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "threetier-cluster"
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "threetier-logs"

}


resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "wordpress-ecs-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.taskdef.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
    security_groups  = [aws_security_group.sg.id]

  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "wordpress-container"
    container_port   = 80
  }
}
// depends_on = [aws_lb_listener.listener]