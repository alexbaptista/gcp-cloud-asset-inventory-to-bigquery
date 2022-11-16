resource "google_bigquery_table" "cloudsql_users" {
  dataset_id          = google_bigquery_dataset.cloud_asset_inventory.dataset_id
  table_id            = var.bigquery_table_cloudsql_users.table_id
  schema              = jsonencode(var.bigquery_table_cloudsql_users.schema)
  description         = var.bigquery_table_cloudsql_users.description
  deletion_protection = false
}