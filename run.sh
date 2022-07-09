#!/bin/bash

sudo rm -rf .terraform/ terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl
/usr/local/bin/terraform init

/usr/local/bin/terraform apply --auto-approve


ip=`/usr/local/bin/terraform output -raw PublicIP`
pass=`/usr/local/bin/terraform output -json password | jq -r '.[0]'`

echo "deploy_user ansible_host=${ip} ansible_ssh_pass=\"${pass}\" ansible_user=root ansible_port=22" > ./ansible_adduser/iplist.txt

ansible-playbook -i ./ansible_adduser/iplist.txt ./ansible_adduser/main.yml
