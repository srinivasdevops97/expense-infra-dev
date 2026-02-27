module "web_alb" {
  source = "terraform-aws-modules/alb/aws"

  internal = false
  name    = "${local.resource_name}-web-alb"  #expense-dev-web-alb
  vpc_id  = local.vpc_id
  subnets = local.public_subnet_ids
  create_security_group = false
  enable_deletion_protection = false

  # Security Group
  security_groups = [data.aws_ssm_parameter.web_alb_sg_id.value]

  tags = merge(
    var.common_tags,
    var.web_alb_tags
  )
}

# listener for http
resource "aws_lb_listener" "http" {
  load_balancer_arn = module.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Application ALB</h1>"
      status_code  = "200"
    }
  }
}

# listener for https
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.https_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb.arn
  }
}


# Use this to create record using module
# if you are using this, you should comment existing data block in data.tf
# You must pass zone_name, not just zone_id.
module "records" {
  source = "terraform-aws-modules/route53/aws"
  create_zone = false
  name = var.zone_name  # srinivas.fun
    
  records = {
    lb_app = {
      name = "expense-${var.environment}"  # expense-dev
      type = "A"

      alias = {
        name                   = module.web_alb.dns_name
        zone_id               = module.web_alb.zone_id
        evaluate_target_health = true
      }
    }
  }
}




