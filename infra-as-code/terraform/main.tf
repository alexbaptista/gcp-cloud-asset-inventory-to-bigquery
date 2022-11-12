terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.42.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  backend "gcs" {}
  required_version = "1.3.3"
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.credentials_file)
}