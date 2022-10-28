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
  user_name     = "vanderson.david"
  token         = "gAAAAABjWtRTEDV1HzI71eE8EK5ptqwsp8PQohzNDXSavV115jvKrr1w9EnWuBJmsMOJ8h-_b_PCm2b9wGtm1Sy4s3bWum3jA4yKpMnhJ1H-WndR7NLnnosz-tbHsIuS3oyI7W0U2RDEt6Mw4DD2qpNScxWlaiHtUn3UzfR-QdBroRtM1Fj0LRbbuC6ByEBGBTUeUXtLCjUiVWT7Y1givyeqr-kKUm9hXcE78_T3aJKw-mppafKsPt8"
  tenant_name   = "0000001-project"
  domain_name   = "0000001-domain"
  region        =  "spo1"

}

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

#Attach FIP instances
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public-net"
}
