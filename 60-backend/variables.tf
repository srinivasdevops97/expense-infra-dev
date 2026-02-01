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

variable "backend_tags" {
    default = {
        component = "backend"
    }
}

# variable "ami_id" {
#     default = "ami-058fbc284998614e2"
# }