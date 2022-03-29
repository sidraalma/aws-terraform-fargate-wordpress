// // data "template_file" "env_vars" {
// //   template = file("env_vars.json")
// // }

// resource "aws_ecs_task_definition" "aws-ecs-task" {
//   family = "wordpress-task"

//   container_definitions = <<DEFINITION
//   [
//     {
//       "name": "ecs-wordpress-container",
//       "image": "docker.io/wprdpress:latest",
//       "entryPoint": [],
//       "essential": true,
//       "portMappings": [
//         {

//           "containerPort": 80,
//           "hostPort": 80
//           "protocol"      = "tcp"
//         }
//       ],
//       "cpu": 256,
//       "memory": 512,
//       "networkMode": "awsvpc"
//     }
//   ]
//   DEFINITION

//   requires_compatibilities = ["FARGATE"]
//   network_mode             = "awsvpc"
//   memory                   = "512"
//   cpu                      = "256"
// //   execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
// //   task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn


// }

// // data "aws_ecs_task_definition" "main" {
// //   task_definition = aws_ecs_task_definition.aws-ecs-task.family









