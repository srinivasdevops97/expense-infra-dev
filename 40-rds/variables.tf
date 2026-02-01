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

variable "rds_tags" {
    default = {
        component = "mysql"
    }
}

variable "zone_name" {
    default = "srinivas.fun"
}