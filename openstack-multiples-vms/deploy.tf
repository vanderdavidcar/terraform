terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
  }
}

# Configure the provider with your Openstack-Edge credentials
provider "openstack" {
  #cloud = "opentack"
  auth_url      = "https://identity.spo1.edge.embratel.cloud:5000/v3"
  user_name     = "username"
  token         = "token"
  tenant_name   = "tenant"
  domain_name   = "domain"
  region        =  "spo1"

}

# Definir na variavel "count" a quantidade de instancias
resource "openstack_compute_instance_v2" "instance_1" {
  count           = 4
  name            = "node-0${count.index}"
  security_groups = ["mercurio"]
  region          = "spo1"
  image_name      = "CentOS-7"
  flavor_name     = "1x small"
  key_pair        = "mercurio"

network {
    name = "0000001-network"
  }
  #user_data = file("bootstrap.sh")
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public-net"
}
