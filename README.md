# Terraform_DigitalOcean_CreateDroplet

Terraform auto create droplet, I ssh key pair and ssh password, In addition, it also has the create volume and attach to this droplet, output will print IP Public + Password.
When create droplet completed, It'll create an user deploy with sudo permission using ansible playbook.

I using this when intergrate with jenkins, so need to change some variables.

```
do_token="YOUR_TOKEN_FROM_DIGITALOCEAN"
do_region="YOUR_REGION"
do_hostname="YOUR_HOSTNAME"
do_size="YOUR_SIZE"

sudo sed -i "s/default = \"s-4vcpu-8gb\"/default = \"$do_size\"/g" variables.tf

sudo sed -i "s/default = \"TDA1\"/default = \"$do_hostname\"/g" variables.tf

sudo sed -i "s/default = 'INPUT_TOKEN_HERE'/default = \"$do_token\"/g" provider.tf

sudo sed -i 's/public_key = \"KEY_HERE\"/public_key = \"ssh-rsa AAAAB3 my@local\"/g' main.tf

sudo chmod +x ./run.sh

./run.sh
```
