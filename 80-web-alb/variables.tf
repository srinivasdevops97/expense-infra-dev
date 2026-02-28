variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        project_name = "expense"
        Terraform = "true"
        environment = "dev"
    }
}

variable "zone_name" {
    default = "srinivas.sbs"
}

variable "web_alb_tags" {
    default = {
        compenent = "web-alb"
    }
}

