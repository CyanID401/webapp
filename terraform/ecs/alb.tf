resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend_alb_sg.id]
  subnets            = var.vpc_public_subnets_ids
}

resource "aws_lb_target_group" "frontend_alb_tg" {
  name        = "frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 5
    path                = "/"
    interval            = 10
  }
}

resource "aws_lb_listener" "frontend_alb_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_alb_tg.arn
  }
}

output "frontend_alb_dns_name" {
  value = aws_lb.frontend_alb.dns_name
  description = "The DNS name of the ALB"
}