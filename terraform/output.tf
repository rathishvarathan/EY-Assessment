output "vpc_network_name" {
  description = "Name of the created VPC network"
  value       = module.vpc.network_name
}

output "vpc_subnet_name" {
  description = "Name of the created subnet"
  value       = module.vpc.subnet_name
}

output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = module.gke.cluster_name
}

output "gke_endpoint" {
  description = "GKE API endpoint"
  value       = module.gke.endpoint
}

output "gke_region" {
  description = "Cluster region"
  value       = var.region
}
