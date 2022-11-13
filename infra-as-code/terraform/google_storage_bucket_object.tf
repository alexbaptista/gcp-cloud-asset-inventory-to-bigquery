resource "google_storage_bucket_object" "get_cloudsql_instance_inventory" {
  bucket         = google_storage_bucket.cloud_functions.name
  name           = "cloudfunctions/${var.cloud_functions_get_cloudsql_instance_inventory_settings.name}/${data.archive_file.get_cloudsql_instance_inventory.output_md5}.zip"
  source         = data.archive_file.get_cloudsql_instance_inventory.output_path
  detect_md5hash = data.archive_file.get_cloudsql_instance_inventory.output_md5
  depends_on = [
    google_storage_bucket.cloud_functions
  ]
}

resource "google_storage_bucket_object" "put_cloudsql_users_to_bigquery" {
  bucket         = google_storage_bucket.cloud_functions.name
  name           = "cloudfunctions/${var.cloud_functions_put_cloudsql_users_to_bigquery_settings.name}/${data.archive_file.put_cloudsql_users_to_bigquery.output_md5}.zip"
  source         = data.archive_file.put_cloudsql_users_to_bigquery.output_path
  detect_md5hash = data.archive_file.put_cloudsql_users_to_bigquery.output_md5
  depends_on = [
    google_storage_bucket.cloud_functions
  ]
}