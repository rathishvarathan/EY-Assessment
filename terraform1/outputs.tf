output "cluster_name" {
 description = "GKE cluster name"
 value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
 description = "Endpoint for the GKE cluster"
 value = google_container_cluster.primary.endpoint
}

output "node_pool_name" {
 description = "Node pool name"
 value = google_container_node_pool.primary_nodes.name
}
