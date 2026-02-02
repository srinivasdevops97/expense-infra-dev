#!/bin/bash

component = $1
environment = $2
component="${var.component}"
environment="${var.environment}"
echo "component: $component, environment: $environment"
dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/srinivasdevops97/expense-ansible-roles-tf.git main.yaml -e component="${var.component}" -e environment="${var.environment}"