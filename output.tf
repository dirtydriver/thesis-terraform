### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
      
  
 content = templatefile("inventory.tmpl",
 {  
  kube-master-dns = digitalocean_droplet.kube-master.*.name,
  kube-master-ip = digitalocean_droplet.kube-master.*.ipv4_address
  kube-worker-dns = digitalocean_droplet.kube-worker.*.name,
  kube-worker-ip = digitalocean_droplet.kube-worker.*.ipv4_address
 }
 )
 filename = "inventory"
}