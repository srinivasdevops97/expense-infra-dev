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
    default = "srinivas.fun"
}

variable "zone_id" {
    default = "Z0064494ETLVXQ79HECR"
}