terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.17.0"
    }
  }
}

provider "google" {
  project = "project-f4bad27f-8327-43c7-b26"
  region  = "europe-west9"
}

# This data source gets a temporary token for the service account
data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "terraform-runner@project-f4bad27f-8327-43c7-b26.iam.gserviceaccount.com"
  scopes                 = ["https://www.googleapis.com/auth/cloud-platform"]
  lifetime               = "3600s"
}

# This second provider block uses that temporary token and does the real work
provider "google" {
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.default.access_token
  project      = "project-f4bad27f-8327-43c7-b26"
  region       = "europe-west9"
  #zone         = var.zone
}

resource "google_storage_bucket" "demo-bucket" {
  provider      = google.impersonated
  name          = "project-f4bad27f-8327-43c7-b26-terra-bucket"
  location      = "EUROPE-WEST9"
  force_destroy = true

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}