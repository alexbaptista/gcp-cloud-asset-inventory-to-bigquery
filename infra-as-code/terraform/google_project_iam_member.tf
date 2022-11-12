resource "google_project_iam_member" "service_account_get_cloudsql_instance_inventory" {
  project = data.google_client_config.current.project
  role    = var.service_account_get_cloudsql_instance_inventory.roles.cloudasset
  member  = google_service_account.get_cloudsql_instance_inventory.member
}