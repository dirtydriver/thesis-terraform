resource "digitalocean_volume" "kube-worker-volume" {
  region                  = "fra1"
  name                    = "kube-worker-volume-${count.index}"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "Docker Storage"
  count = var.instance
}

resource "digitalocean_droplet" "kube-worker" {

    count = var.instance
    image="ubuntu-20-04-x64"
    name="kube-worker-${count.index}"
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
  provisioner "file"{

    
  }


}



resource "digitalocean_volume_attachment" "kube-volumes" {
  count = var.instance
  droplet_id = digitalocean_droplet.kube-worker[count.index].id
  volume_id  = digitalocean_volume.kube-worker-volume[count.index].id

  
  provisioner "remote-exec"{

    connection {

    host = digitalocean_droplet.kube-worker[count.index].ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
    }

    inline=[
      "export PATH=$PATH:/usr/bin",
      "mkdir -p /var/lib/docker",
      "mount /dev/sda /var/lib/docker",

      "echo   "
    ]

  } 


}