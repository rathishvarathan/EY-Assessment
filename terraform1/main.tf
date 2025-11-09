resource "google_container_cluster" "primary" {
 name = var.cluster_name
 location = var.zone

 remove_default_node_pool = true
 initial_node_count = 1

 ip_allocation_policy {}

 networking_mode = "VPC_NATIVE"

 node_config {
 machine_type = "e2-medium"
 image_type = "COS_CONTAINERD"
 oauth_scopes = [
 "https://www.googleapis.com/auth/cloud-platform",
 ]
 labels = {
 env = "dev"
 }
 tags = ["gke-node"]
 }
}

resource "google_container_node_pool" "primary_nodes" {
 name = "primary-pool"
 cluster = google_container_cluster.primary.name
 location = var.zone

 node_count = 2

 autoscaling {
 min_node_count = 1
 max_node_count = 3
 }

 node_config {
 preemptible = false
 machine_type = "e2-medium"
 oauth_scopes = [
 "https://www.googleapis.com/auth/cloud-platform",
 ]
 labels = {
 pool = "primary"
 }
 tags = ["gke-node"]
 }
}
