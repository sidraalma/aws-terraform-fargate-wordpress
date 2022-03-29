resource "aws_ecs_task_definition" "taskdef" {
  family                   = "wordpress-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  #execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  #task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([{
    name      = "wordpress-container",
    image     = "docker.io/wordpress:latest",
    essential = true,
    environment = [
      {
      name = "WORDPRESS_DB_HOST", 
      value = "${aws_db_instance.rds.address}"
      },
      {name = "WORDPRESS_DB_USER", 
      value = "admin"},
      {
      name = "WORDPRESS_DB_PASSWORD", 
      value = "wordpress"},
      {
      name = "WORDPRESS_DB_NAME", 
      value = "wordpress"},
      {name = "WORDPRESS_DB_PORT", 
      value = "3306"}
          ],
    portMappings = [{
      protocol      = "tcp",
      containerPort = 80,
      hostPort      = 80
    }]
  }])
}


