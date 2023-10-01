
resource "digitalocean_droplet" "kube-worker" {

    count = var.worker
    image="ubuntu-20-04-x64"
    name="kube-worker-${count.index}"
    region="fra1"
    size="s-1vcpu-1gb"
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
      "ln -s /mnt/docker_worker${count.index} /var/lib/docker"
    ]
  } 

}

resource "digitalocean_volume" "docker-worker" {
  region                  = "fra1"
  name                    = "docker-worker${count.index}"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "Docker Storage"
  count = var.worker
}

resource "digitalocean_volume_attachment" "kube-volumes-worker" {
  count = var.worker
  droplet_id = digitalocean_droplet.kube-worker[count.index].id
  volume_id  = digitalocean_volume.docker-worker[count.index].id
}