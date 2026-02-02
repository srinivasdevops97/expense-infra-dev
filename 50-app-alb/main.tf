module "app_alb" {
  source = "terraform-aws-modules/alb/aws"

  internal = true
  name    = "${local.resource_name}-app-alb"  #expense-dev-app-alb
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  create_security_group = false
  enable_deletion_protection = false

  # Security Group
  security_groups = [data.aws_ssm_parameter.app_alb_sg_id.value]

  tags = merge(
    var.common_tags,
    var.app_alb_tags
  )
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = module.app_alb.arn
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

# Use this to create record using module
# if you are using this, you should comment existing data block in data.tf
# You must pass zone_name, not just zone_id.
module "records" {
  source = "terraform-aws-modules/route53/aws"
  create_zone = false
  name = var.zone_name
    
  records = {
    lb_app = {
      name = "*.app-${var.environment}"
      type = "A"

      alias = {
        name                   = module.app_alb.dns_name
        zone_id               = module.app_alb.zone_id
        evaluate_target_health = true
      }
    }
  }
}

# # Use this resource to create record using resource
# # if you use this resource, you should uncomment existing data block in data.tf
# resource "aws_route53_record" "app_alb" {
#   zone_id = data.aws_route53_zone.existing.zone_id
#   name    = "*.app-${var.environment}"
#   type    = "A"

#   alias {
#     name                   = module.app_alb.dns_name
#     zone_id                = module.app_alb.zone_id
#     evaluate_target_health = true
#   }
# }
