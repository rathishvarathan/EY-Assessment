variable "project_defaults" {
  description = "Default settings for the project"
  type = map(any)
  default = {
    project_id       = "my-gcp-project"
    region           = "us-central1"
    zone              = "us-central1-a"
    cluster_name      = "gke-standard-private"
  }
}