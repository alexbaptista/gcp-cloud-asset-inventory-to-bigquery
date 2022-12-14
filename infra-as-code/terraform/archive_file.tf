data "archive_file" "get_cloudsql_instance_inventory" {
  type        = "zip"
  source_dir  = var.cloud_functions_get_cloudsql_instance_inventory
  output_path = "${var.cloud_functions_get_cloudsql_instance_inventory}.zip"
}

data "archive_file" "put_cloudsql_users_to_bigquery" {
  type        = "zip"
  source_dir  = var.cloud_functions_put_cloudsql_users_to_bigquery
  output_path = "${var.cloud_functions_put_cloudsql_users_to_bigquery}.zip"
}