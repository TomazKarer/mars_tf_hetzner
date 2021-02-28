terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.24.0"
    }
  }
}
# API token za upravljanje Hetznerja
variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_network" "network" {
  name = "mars_network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_server" "server" {
  name = "mars"
  server_type = "cx11"
  image = "debian-10"
  location = "nbg1"
  ssh_keys = [hcloud_ssh_key.default.id]

#  network { 
#    network_id = hcloud_network.network.id
#    ip = "10.0.1.5"
#  }
}

output "instance_ip_addr" {
  value = hcloud_server.server.ipv4_address
}


resource "hcloud_ssh_key" "default" {
  name = "mars_ssh"
  public_key = file("../secrets/id_rsa.mars.hetzner.pub")
}

resource "local_file" "hosts_cfg" {
  content = templatefile("./templates/hosts.tpl",
    {
      hosts = hcloud_server.server.*.ipv4_address
    }
  )
  filename = "./ansible/inventory/hosts.cfg"
}

