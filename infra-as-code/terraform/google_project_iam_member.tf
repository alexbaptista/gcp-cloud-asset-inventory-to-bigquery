resource "google_project_iam_member" "service_account_get_cloudsql_instance_inventory" {
  project = data.google_client_config.current.project
  role    = var.service_account_get_cloudsql_instance_inventory.roles.cloudasset
  member  = google_service_account.get_cloudsql_instance_inventory.member
}

resource "google_project_iam_member" "service_account_put_cloudsql_users_to_bigquery" {
  project = data.google_client_config.current.project
  role    = var.service_account_put_cloudsql_users_to_bigquery.roles.cloudsql
  member  = google_service_account.put_cloudsql_users_to_bigquery.member
}