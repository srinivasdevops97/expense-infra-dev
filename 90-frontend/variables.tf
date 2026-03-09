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

variable "frontend_tags" {
    default = {
        component = "frontend"
    }
}

variable "zone_name" {
    default = "srinivas.sbs"
}
