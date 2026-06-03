resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets         = var.subnet_ids

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.alb_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.alb_name}-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
