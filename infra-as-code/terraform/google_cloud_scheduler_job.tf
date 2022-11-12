resource "google_cloud_scheduler_job" "cron" {
  name        = var.scheduler_job_cron.name
  description = var.scheduler_job_cron.description
  schedule    = var.scheduler_job_cron.schedule
  time_zone   = var.scheduler_job_cron.time_zone

  pubsub_target {
    topic_name = google_pubsub_topic.scheduler_job.id
    data       = base64encode(jsonencode(var.scheduler_job_cron.pubsub_target.data))
  }
}