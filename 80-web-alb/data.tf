data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "web_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
}

data "aws_ssm_parameter" "https_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/https_certificate_arn"
}

# data "aws_route53_zone" "existing" {
#   name         = "srinivas.fun"
#   private_zone = false
# }