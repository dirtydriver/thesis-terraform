resource "digitalocean_droplet" "kube-master" {

    count = var.instance
    image="ubuntu-20-04-x64"
    name="kube-master-${count.index}"
    region="fra1"
    size="s-4vcpu-8gb"
    private_networking= true
    ssh_keys = [
        data.digitalocean_ssh_key.zenbook.id
    ]
    
  connection {

    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"

}
}

resource "digitalocean_volume" "kube-master-volume" {
  region                  = "fra1"
  name                    = "kube-master-volume-${count.index}"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "Docker Storage"
  count = var.instance
}

resource "digitalocean_volume_attachment" "kube-volumes" {
  count = var.instance
  droplet_id = digitalocean_droplet.kube-master[count.index].id
  volume_id  = digitalocean_volume.kube-master-volume[count.index].id
}