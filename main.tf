resource "random_string" "random" {
  length  = 12
  special = false
  #override_special = "/@£$"
}

#resource "digitalocean_ssh_key" "rootkey" {
#  name = "rootkey"
#  public_key = "KEY_HERE"
#public_key = file("/opt/terraform/id_rsa.pub")
#public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiNdgoKnX13LipucnX1jXk/YFvmtgTlHmDGqvJZ9Pfv+EIKt3LlCdYIMSle6+QgGK1QcmNLqSUaACIsRvUAWUBC+yS5mY3GiC6p9I/GAdNdg5omVtA0dabsgcbQixnrSQqxvq+WgtmEMBXmeKM8fmIZ4nyRH2VD49r/iC+Bnc9b7uDafnff37wZi6bqG55wVWOLA88mZvqYAzcq5ccd1wV014zTVCeEY1tEgM4u+jYw1W/fc0U2gxViaJ0fPFrBxdKUXPUgNi6VTZbDb0C0cE4GVAstOl5jBsqBvdnQykHpOjqfON2KV2g2WBdQRaM2OWOoJVOaEhZzy8Z2rLI+W55"
#}

resource "vultr_ssh_key" "rootkey" {
  name = "Root SSH key"
  ssh_key = "${file("./sshkey.pub")}"
}

resource "vultr_instance" "new_instance" {
  plan        = var.plan
  region      = var.region
  os_id       = var.os_id
  label       = var.label
  tags        = ["${var.label}"]
  ssh_key_ids = ["${vultr_ssh_key.rootkey.id}"]
  hostname    = "${var.label}.local"
  enable_ipv6 = false
  backups     = "disabled"
  #backups_schedule {
  #  type = "daily"
  #}
  ddos_protection  = false
  activation_email = false

  provisioner "remote-exec" {
    inline = [
      "sed -i '/^PasswordAuthentication/s/^.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config",
      "yum install -y sshpass",
      "echo ${random_string.random.id} | passwd --stdin root",
      "systemctl restart sshd"
    ]
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/home/tritran/Desktop/id_rsa")
      #private_key = file("/opt/terraform/id_rsa")
      host = self.main_ip
      timeout = "10m"
    }
  }
}

/*resource "digitalocean_volume" "volume-droplet-1" {
  region                  = var.do_region
  #name                    = join("", ["Volume", var.do_name])
  name = "volume-droplet-1"
  size                    = 100
  initial_filesystem_type = "xfs"
  description             = "add more volume to droplet"
}

resource "digitalocean_volume_attachment" "droplet-atach" {
  droplet_id = digitalocean_droplet.droplet-1.id
  volume_id  = digitalocean_volume.volume-droplet-1.id
}*/
