variable "openstack_user_name" {}
variable "openstack_token" {}
variable "openstack_tenant_name" {}
variable "openstack_domain_name" {}
variable "openstack_auth_url" {}
variable "openstack_region" {}

variable "image" {
  default = "CentOS-7"
}

# Instances quantity
variable "num" {
  default = "4"
}

variable "flavor" {
  default = "1x small"
}

variable "ssh_key_pair" {
  default = "mercurio"
}

variable "ssh_user_name" {
  default = "root"
}

variable "region" {
	default = "spo1"
}

variable "security_group" {
	default = "mercurio"
}

variable "network" {
	default  = "0000001-network"
}

variable "pool" {
  default = "public-net"
}