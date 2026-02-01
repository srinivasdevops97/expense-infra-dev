data "aws_ssm_parameter" "backend_sg_id" {
  #/expense/dev/backend_sg_id
  name = "/${var.project_name}/${var.environment}/backend_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  #/expense/dev/private_subnet_ids
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ami" "joindevops" {
    most_recent = true
    owners = ["973714476881"]

    filter {
        name   = "name"
        values = ["Redhat-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}