# main.tf

provider "google" {
  project = "rec-project-gcp"   # Project ID where the bucket will be created
}

resource "google_storage_bucket" "test_bucket" {
  name     = "my-test-bucket-rec-project-gcp"  # Unique name for the bucket
  location = "EU"                              # GCS location (US, EU, or a specific region like us-central1)
}

resource "google_storage_bucket" "test_bucket_2" {
  name     = "my-second-test-bucket-rec-project-gcp"  # Unique name for the bucket
  location = "EU"                                     # GCS location (US, EU, or a specific region like us-central1)
}

# Outputs (optional but helpful to confirm)
output "bucket_name" {
  value = google_storage_bucket.test_bucket.name
}
