terraform {
 required_providers {
 google = {
 source = "hashicorp/google"
 version = ">= 4.0"
 }
 }
 required_version = ">= 1.3.0"
}

provider "google" {
 project = var.project
 region = var.region
 zone = var.zone
 credentials = file("/home/rathishkaliyugavarathan14/terraform-sa-key.json")
}
