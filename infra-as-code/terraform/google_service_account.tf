resource "google_service_account" "get_cloudsql_instance_inventory" {
  account_id   = var.service_account_get_cloudsql_instance_inventory.account_id
  display_name = var.service_account_get_cloudsql_instance_inventory.display_name
}

resource "google_service_account" "put_cloudsql_users_to_bigquery" {
  account_id   = var.service_account_put_cloudsql_users_to_bigquery.account_id
  display_name = var.service_account_put_cloudsql_users_to_bigquery.display_name
}