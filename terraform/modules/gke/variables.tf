variable "project_id" {}
variable "region" {}
variable "cluster_name" {}
variable "network_name" {}
variable "subnetwork" {}
variable "master_ipv4_cidr_block" {}
variable "node_pools" {
  description = "List of node pool configurations"
  type = list(object({
    name         = string
    machine_type = string
    min_count    = number
    max_count    = number
    disk_size_gb = number
    labels       = map(string)
  }))
}
