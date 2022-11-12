resource "google_bigquery_dataset_iam_member" "service_account_put_cloudsql_users_to_bigquery" {
  dataset_id = google_bigquery_dataset.cloud_asset_inventory.dataset_id
  role       = var.service_account_put_cloudsql_users_to_bigquery.roles.bigquery
  member     = google_service_account.put_cloudsql_users_to_bigquery.member
}