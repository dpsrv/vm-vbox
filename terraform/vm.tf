resource "virtualbox_vm" "dpsrv" {
  name      = "dpsrv"
  image     = "https://app.vagrantup.com/fedora/boxes/39-cloud-base/versions/39.20231031.1/providers/virtualbox/amd64/vagrant.box"
  cpus      = 2
  memory    = "512 mib"
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "bridged"
  }
}
