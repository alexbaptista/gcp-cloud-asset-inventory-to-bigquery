resource "google_storage_bucket_object" "get_cloudsql_instance_inventory" {
  bucket = google_storage_bucket.cloud_functions.name
  name   = var.cloud_functions_get_cloudsql_instance_inventory.name
  source = var.cloud_functions_get_cloudsql_instance_inventory.source
  depends_on = [
    google_storage_bucket.cloud_functions
  ]
}

resource "google_storage_bucket_object" "put_cloudsql_users_to_bigquery" {
  bucket = google_storage_bucket.cloud_functions.name
  name   = var.cloud_functions_put_cloudsql_users_to_bigquery.name
  source = var.cloud_functions_put_cloudsql_users_to_bigquery.source
  depends_on = [
    google_storage_bucket.cloud_functions
  ]
}