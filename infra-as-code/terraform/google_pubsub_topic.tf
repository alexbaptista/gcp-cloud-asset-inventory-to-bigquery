resource "google_pubsub_topic" "scheduler_job" {
  name                       = var.topic_scheduler_job.name
  message_retention_duration = var.topic_scheduler_job.message_retention_duration
}

resource "google_pubsub_topic" "bigquery" {
  name                       = var.topic_bigquery.name
  message_retention_duration = var.topic_bigquery.message_retention_duration
}