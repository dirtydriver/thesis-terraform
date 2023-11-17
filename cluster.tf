resource "digitalocean_kubernetes_cluster" "gdf_thesis" {
  name   = "gdf-thesis"
  region = "fra1"
  version = "1.28.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    auto_scale = true
    min_nodes = 2
    max_nodes = 4
  }
}
output "cluster-id" {
  value = "${digitalocean_kubernetes_cluster.gdf_thesis.id}"
}