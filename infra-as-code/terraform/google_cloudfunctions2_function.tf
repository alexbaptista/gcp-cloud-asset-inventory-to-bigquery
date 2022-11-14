resource "google_cloudfunctions2_function" "get_cloudsql_instance_inventory" {
  name        = "${var.cloud_functions_get_cloudsql_instance_inventory_settings.name}-${random_string.cloud_functions_get_cloudsql_instance_inventory.id}"
  description = var.cloud_functions_get_cloudsql_instance_inventory_settings.description
  location    = data.google_client_config.current.region

  build_config {
    runtime     = var.cloud_functions_get_cloudsql_instance_inventory_settings.build_config.runtime
    entry_point = var.cloud_functions_get_cloudsql_instance_inventory_settings.build_config.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.cloud_functions.name
        object = google_storage_bucket_object.get_cloudsql_instance_inventory.output_name
      }
    }
  }

  service_config {
    max_instance_count = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.max_instance_count
    min_instance_count = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.min_instance_count
    available_memory   = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.available_memory
    timeout_seconds    = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.timeout_seconds
    environment_variables = {
      PUBSUB_TOPIC_PATH = google_pubsub_topic.bigquery.id
      GCP_PROJECT       = data.google_project.current.number
    }
    ingress_settings               = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.ingress_settings
    all_traffic_on_latest_revision = var.cloud_functions_get_cloudsql_instance_inventory_settings.service_config.all_traffic_on_latest_revision
    service_account_email          = google_service_account.get_cloudsql_instance_inventory.email
  }

  event_trigger {
    event_type     = var.cloud_functions_get_cloudsql_instance_inventory_settings.event_trigger.event_type
    retry_policy   = var.cloud_functions_get_cloudsql_instance_inventory_settings.event_trigger.retry_policy
    pubsub_topic   = google_pubsub_topic.scheduler_job.id
    trigger_region = data.google_client_config.current.region
  }

  depends_on = [
    google_pubsub_topic_iam_member.service_account_get_cloudsql_instance_inventory,
    google_project_iam_member.service_account_get_cloudsql_instance_inventory
  ]
}

resource "google_cloudfunctions2_function" "put_cloudsql_users_to_bigquery" {
  name        = "${var.cloud_functions_put_cloudsql_users_to_bigquery_settings.name}-${random_string.cloud_functions_put_cloudsql_users_to_bigquery.id}"
  description = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.description
  location    = data.google_client_config.current.region

  build_config {
    runtime     = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.build_config.runtime
    entry_point = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.build_config.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.cloud_functions.name
        object = google_storage_bucket_object.put_cloudsql_users_to_bigquery.output_name
      }
    }
  }

  service_config {
    max_instance_count = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.max_instance_count
    min_instance_count = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.min_instance_count
    available_memory   = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.available_memory
    timeout_seconds    = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.timeout_seconds
    environment_variables = {
      BIGQUERY_TABLE_ID = join(".", setsubtract(split("/", google_bigquery_table.cloudsql_users.id), ["projects", "datasets", "tables"]))
    }
    ingress_settings               = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.ingress_settings
    all_traffic_on_latest_revision = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.service_config.all_traffic_on_latest_revision
    service_account_email          = google_service_account.put_cloudsql_users_to_bigquery.email
  }

  event_trigger {
    event_type     = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.event_trigger.event_type
    retry_policy   = var.cloud_functions_put_cloudsql_users_to_bigquery_settings.event_trigger.retry_policy
    pubsub_topic   = google_pubsub_topic.bigquery.id
    trigger_region = data.google_client_config.current.region
  }

  depends_on = [
    google_bigquery_dataset_iam_member.service_account_put_cloudsql_users_to_bigquery,
    google_bigquery_table.cloudsql_users
  ]
}