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

variable "vpn_tags" {
    default = {
        component = "vpn"
    }
}

# variable "ami_id" {
#     default = "ami-058fbc284998614e2"
# }