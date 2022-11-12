resource "random_string" "storage_bucket_name_suffix" {
  length           = var.random_name_suffix_for_storage_bucket.length
  special          = var.random_name_suffix_for_storage_bucket.special
  override_special = var.random_name_suffix_for_storage_bucket.override_special
  upper            = var.random_name_suffix_for_storage_bucket.upper
}