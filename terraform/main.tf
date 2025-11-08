# Custom VPC
module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  network_name = "gke-custom-vpc"
}

# GKE cluster
module "gke" {
  source = "./modules/gke"

  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name

  network_name = module.vpc.network_name
  subnetwork   = module.vpc.subnet_name

  master_ipv4_cidr_block = "172.16.0.0/28"

  node_pools = [
    {
      name         = "system-pool"
      machine_type = "e2-medium"
      min_count    = 1
      max_count    = 3
      disk_size_gb = 50
      labels = {
        role = "system"
      }
    },
    {
      name         = "general-pool"
      machine_type = "e2-standard-4"
      min_count    = 0
      max_count    = 5
      disk_size_gb = 100
      labels = {
        role = "general"
      }
    }
  ]
}

output "cluster_name" {
  value = module.gke.cluster_name
}

output "endpoint" {
  value = module.gke.endpoint
}

output "vpc_name" {
  value = module.vpc.network_name
}
