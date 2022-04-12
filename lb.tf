locals {
  full_name = "lb-${var.internal ? "int-" : ""}${var.cluster_name}-${var.app_name}"

  // We meed to trim the name down to a max of 32 characters and it cannot end with a hyphen.
  name = regex("(.+?)-?$", substr(local.full_name, 0, min(length(local.full_name), 32)))[0]
}

resource "aws_lb" "app_lb" {
  name               = local.name
  load_balancer_type = "application"
  security_groups    = flatten([var.security_groups])
  subnets            = flatten([var.subnets])
  internal           = var.internal
  idle_timeout       = var.idle_timeout

  access_logs {
    enabled = var.access_logs_enabled
    bucket  = var.access_logs_bucket
    prefix  = "${var.app_name}-logs"
  }

  tags = {
    Name = "Application LB ${var.app_name}"
  }
}

resource "aws_lb_listener" "secure_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "redirect_listener" {
  count = var.secure_listener_redirect ? 1 : 0

  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# typically not used unless you have a client that can't follow redirects for some reason
resource "aws_lb_listener" "insecure_listener" {
  count = var.secure_listener_redirect ? 0 : 1

  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}
