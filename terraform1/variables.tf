variable "project" {
 description = "GCP Project ID"
 type = string
 default = "sinuous-origin-477316-k7"
}

variable "region" {
 description = "Region for GKE cluster"
 type = string
 default = "us-central1"
}

variable "zone" {
 description = "Zone for GKE cluster"
 type = string
 default = "us-central1-a"
}

variable "credentials_file" {
 description = "Path to the service account key JSON file"
 type = string
 default = "~/terraform-sa-key.json"
}

variable "cluster_name" {
 description = "Name of the GKE cluster"
 type = string
 default = "gke-demo-cluster"
}
