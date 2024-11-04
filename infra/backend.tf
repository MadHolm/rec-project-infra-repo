# backend.tf

terraform {
  backend "gcs" {
    bucket  = "rec-project-infra-repo-tf-state"  # Replace with your GCS bucket name
    prefix  = "terraform/state"              # Optional folder structure in the bucket
  }
}
