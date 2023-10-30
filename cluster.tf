resource "digitalocean_kubernetes_cluster" "gdf_thesis" {
  name   = "gdf-thesis"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.19.3-do.3"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}
output "cluster-id" {
  value = "${digitalocean_kubernetes_cluster.gdf_thesis.id}"
}