
resource "digitalocean_droplet" "kube-master" {

    count = var.master
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
  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt upgrade -y",
      #Create link from volume to docker directory
      "ln -s /mnt/docker_master${count.index} /var/lib/docker"
    ]
  }
}

resource "digitalocean_volume" "docker" {
  region                  = "fra1"
  name                    = "docker-master${count.index}"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "Docker Storage"
  count = var.master
}


resource "digitalocean_volume_attachment" "kube-volumes-master" {
  count = var.master
  droplet_id = digitalocean_droplet.kube-master[count.index].id
  volume_id  = digitalocean_volume.docker[count.index].id
}