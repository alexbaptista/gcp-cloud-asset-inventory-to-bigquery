resource "google_storage_bucket" "cloud_functions" {
  name                        = "${var.storage_bucket_for_cloud_functions.name_prefix}-${random_string.storage_bucket_name_suffix.id}"
  location                    = data.google_client_config.current.region
  uniform_bucket_level_access = var.storage_bucket_for_cloud_functions.uniform_bucket_level_access
  public_access_prevention    = var.storage_bucket_for_cloud_functions.public_access_prevention
  force_destroy               = var.storage_bucket_for_cloud_functions.force_destroy # Only to enable Terraform to delete all resources when it's necessary

  versioning {
    enabled = var.storage_bucket_for_cloud_functions.versioning.enabled
  }
}