variable "project" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Resources location"
}

variable "credentials_file" {
  type        = string
  description = "GCP credential file location"
}

variable "scheduler_job_cron" {
  type = object({
    description = string
    name        = string
    pubsub_target = object({
      data = object({
        assetTypes = list(string)
      })
    })
    schedule  = string
    time_zone = string
  })
  default = {
    description = "Cron that send a message to a Pub/Sub that will trigger a Cloud Functions"
    name        = "scheduler-job-for-trigger-cf"
    pubsub_target = {
      data = {
        assetTypes = ["sqladmin.googleapis.com/Instance"]
      }
    }
    schedule  = "*/2 * * * *"
    time_zone = "America/Sao_Paulo"
  }
  description = "Settings for Cloud Scheduler Job"
}

variable "topic_scheduler_job" {
  type = object({
    name = string
  })
  default = {
    name = "pub-sub-for-trigger-cloudfunctions"
  }
  description = "Settings for Pub Sub"
}

variable "topic_bigquery" {
  type = object({
    name = string
  })
  default = {
    name = "pub-sub-for-put-data-into-bigquery"
  }
  description = "Settings for Pub Sub"
}

variable "bigquery_dataset_cloud_asset_inventory" {
  type = object({
    dataset_id  = string
    description = string
  })
  default = {
    dataset_id  = "cloud_asset_inventory"
    description = "Dataset for Cloud Asset Inventory Data"
  }
  description = "Dataset to put data onto BigQuery"
}

variable "bigquery_table_cloudsql_users" {
  type = object({
    table_id = string
    schema = list(object({
      name = string
      type = string
      mode = string
    }))
    description = string
  })
  default = {
    table_id    = "cloudsql_users"
    description = "Table with Database users from CloudSQL"
    schema = [{
      mode = "NULLABLE"
      name = "name"
      type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "type"
        type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "api"
        type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "location"
        type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "api_updated_at"
        type = "DATETIME"
      },
      {
        mode = "NULLABLE"
        name = "users"
        type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "error"
        type = "JSON"
      },
      {
        mode = "NULLABLE"
        name = "created_at"
        type = "DATETIME"
    }]
  }
  description = "Table to put data onto BigQuery"
}

variable "service_account_get_cloudsql_instance_inventory" {
  type = object({
    account_id   = string
    display_name = string
    roles        = map(string)
  })
  default = {
    account_id   = "cloudsql-instance-inventory"
    display_name = "SA for CF get-cloudsql-instance-inventory"
    roles = {
      "pubsub"     = "roles/pubsub.publisher"
      "cloudasset" = "roles/cloudasset.viewer"
    }
  }
  description = "Settings for Service Account"
}

variable "service_account_put_cloudsql_users_to_bigquery" {
  type = object({
    account_id   = string
    display_name = string
    roles        = map(string)
  })
  default = {
    account_id   = "cloudsql-users-to-bigquery"
    display_name = "SA for CF put-cloudsql-users-to-bigquery"
    roles = {
      "bigquery" = "roles/bigquery.dataEditor"
      "cloudsql" = "roles/cloudsql.viewer"
    }
  }
  description = "Settings for Service Account"
}


variable "storage_bucket_for_cloud_functions" {
  type = object({
    force_destroy               = bool
    name_prefix                 = string
    public_access_prevention    = string
    uniform_bucket_level_access = bool
    versioning = object({
      enabled = bool
    })
  })
  default = {
    force_destroy               = true
    name_prefix                 = "cf-storage-bucket"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning = {
      enabled = true
    }
  }
  description = "Settings for Storage Bucket"
}

variable "random_name_suffix_for_storage_bucket" {
  type = object({
    length           = number
    override_special = string
    special          = bool
    upper            = bool
  })
  default = {
    length           = 6
    override_special = "/@£$"
    special          = false
    upper            = false
  }
  description = "Settings for Storage Bucket random name suffix"
}

variable "random_name_suffix_for_cloud_functions" {
  type = object({
    length           = number
    override_special = string
    special          = bool
    upper            = bool
  })
  default = {
    length           = 6
    override_special = "/@£$"
    special          = false
    upper            = false
  }
  description = "Settings for Cloud Functions random name suffix"
}

variable "cloud_functions_get_cloudsql_instance_inventory" {
  type        = string
  default     = "../../cloud_functions/get_cloudsql_instance_inventory"
  description = "Source path to upload source code for Cloud Functions"
}

variable "cloud_functions_put_cloudsql_users_to_bigquery" {
  type        = string
  default     = "../../cloud_functions/put_cloudsql_users_to_bigquery"
  description = "Source path to upload source code for Cloud Functions"
}

variable "cloud_functions_get_cloudsql_instance_inventory_settings" {
  type = object({
    build_config = object({
      entry_point = string
      runtime     = string
    })
    description = string
    event_trigger = object({
      event_type   = string
      retry_policy = string
    })
    name = string
    service_config = object({
      all_traffic_on_latest_revision = bool
      available_memory               = string
      ingress_settings               = string
      max_instance_count             = number
      min_instance_count             = number
      timeout_seconds                = number
    })
  })
  default = {
    build_config = {
      entry_point = "main_function"
      runtime     = "python310"
    }
    description = "Function to get data from Cloud Asset Inventory and put message on Pub/Sub"
    event_trigger = {
      event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
      retry_policy = "RETRY_POLICY_RETRY"
    }
    name = "get-cloudsql-instance-inventory"
    service_config = {
      all_traffic_on_latest_revision = true
      available_memory               = "256Mi"
      ingress_settings               = "ALLOW_INTERNAL_ONLY"
      max_instance_count             = 5
      min_instance_count             = 0
      timeout_seconds                = 60
    }
  }
  description = "Settings for Cloud Function"
}

variable "cloud_functions_put_cloudsql_users_to_bigquery_settings" {
  type = object({
    build_config = object({
      entry_point = string
      runtime     = string
    })
    description = string
    event_trigger = object({
      event_type   = string
      retry_policy = string
    })
    name = string
    service_config = object({
      all_traffic_on_latest_revision = bool
      available_memory               = string
      ingress_settings               = string
      max_instance_count             = number
      min_instance_count             = number
      timeout_seconds                = number
    })
  })
  default = {
    build_config = {
      entry_point = "main_function"
      runtime     = "python310"
    }
    description = "Function to get data from Pub/Sub and put message onto BigQuery"
    event_trigger = {
      event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
      retry_policy = "RETRY_POLICY_RETRY"
    }
    name = "put-cloudsql-users-to-bigquery"
    service_config = {
      all_traffic_on_latest_revision = true
      available_memory               = "256Mi"
      ingress_settings               = "ALLOW_INTERNAL_ONLY"
      max_instance_count             = 5
      min_instance_count             = 0
      timeout_seconds                = 60
    }
  }
  description = "Settings for Cloud Function"
}
