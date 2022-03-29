resource "aws_alb" "application_load_balancer" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.sg.id]

  tags = {
    Name = var.default_tags.project
  }
}


resource "aws_lb_target_group" "target_group" {
  name        = "threetier-wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  //   health_check {
  //     healthy_threshold   = "3"
  //     interval            = "300"
  //     protocol            = "HTTP"
  //     matcher             = "200"
  //     timeout             = "3"
  //     path                = "/v1/status"
  //     unhealthy_threshold = "2"
  //   }

  tags = {
    Name = var.default_tags.project
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}