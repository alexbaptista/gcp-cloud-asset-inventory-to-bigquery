resource "google_pubsub_topic" "scheduler_job" {
  name = var.topic_scheduler_job
}

resource "google_pubsub_topic" "bigquery" {
  name = var.topic_bigquery
}