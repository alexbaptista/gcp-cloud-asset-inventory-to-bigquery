resource "google_pubsub_topic_iam_member" "service_account_get_cloudsql_instance_inventory" {
  topic  = google_pubsub_topic.bigquery.id
  role   = var.service_account_get_cloudsql_instance_inventory.roles.pubsub
  member = google_service_account.get_cloudsql_instance_inventory.member
}