resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = var.network_name
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1
  enable_autopilot         = false

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {}

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks = [{
      cidr_block   = "0.0.0.0/0"
      display_name = "public-access"
    }]
  }

  # Node Auto-Provisioning (NAP)
  cluster_autoscaling {
    enabled = true

    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 50
    }

    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 200
    }

    auto_provisioning_defaults {
      service_account = "default"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
      boot_disk_kms_key = null
      disk_size_gb      = 100
      disk_type         = "pd-standard"
      min_cpu_platform  = "AUTOMATIC"
      shielded_instance_config {
        enable_secure_boot = true
      }
    }
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
}

# Node Pools
resource "google_container_node_pool" "pools" {
  for_each = { for np in var.node_pools : np.name => np }

  name     = each.value.name
  cluster  = google_container_cluster.primary.name
  location = var.region

  node_config {
    machine_type = each.value.machine_type
    disk_size_gb = each.value.disk_size_gb
    labels       = each.value.labels
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    tags         = ["gke-node"]
  }

  autoscaling {
    min_node_count = each.value.min_count
    max_node_count = each.value.max_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
