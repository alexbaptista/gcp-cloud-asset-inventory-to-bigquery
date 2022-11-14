resource "random_string" "storage_bucket_name_suffix" {
  length           = var.random_name_suffix_for_storage_bucket.length
  special          = var.random_name_suffix_for_storage_bucket.special
  override_special = var.random_name_suffix_for_storage_bucket.override_special
  upper            = var.random_name_suffix_for_storage_bucket.upper
}

resource "random_string" "cloud_functions_get_cloudsql_instance_inventory" {
  length           = var.random_name_suffix_for_cloud_functions.length
  special          = var.random_name_suffix_for_cloud_functions.special
  override_special = var.random_name_suffix_for_cloud_functions.override_special
  upper            = var.random_name_suffix_for_cloud_functions.upper
}

resource "random_string" "cloud_functions_put_cloudsql_users_to_bigquery" {
  length           = var.random_name_suffix_for_cloud_functions.length
  special          = var.random_name_suffix_for_cloud_functions.special
  override_special = var.random_name_suffix_for_cloud_functions.override_special
  upper            = var.random_name_suffix_for_cloud_functions.upper
}