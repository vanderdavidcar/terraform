terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
  }
}

resource "openstack_compute_instance_v2" "instance_1" {
  provider = openstack.ovh
  count           = "${var.num}"
  name            = "node0${count.index+1}"
  security_groups = ["${var.security_group}"]
  region          = "${var.region}"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${var.ssh_key_pair}"

network {
    name = "${var.network}"
  }
  
  user_data = "${file("motd.sh")}"
}

# Option if needed in every instances
resource "openstack_compute_floatingip_v2" "floatIP" {
  provider = openstack.ovh
  count = "${var.num}"
  pool = "${var.pool}"
}

resource "openstack_compute_floatingip_associate_v2" "floatIP" {
  provider = openstack.ovh
  count = "${var.num}"
  floating_ip = "${element(openstack_compute_floatingip_v2.floatIP.*.address, count.index)}"
  instance_id = "${element(openstack_compute_instance_v2.instance_1.*.id, count.index)}"
}

output "floatingAddress" {
  value = "${openstack_compute_floatingip_associate_v2.floatIP.*.floating_ip}"
}
