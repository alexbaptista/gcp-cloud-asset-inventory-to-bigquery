## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.3 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.42.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 4.42.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.cloud_asset_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_dataset_iam_member.service_account_put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/bigquery_dataset_iam_member) | resource |
| [google_bigquery_table.cloudsql_users](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/bigquery_table) | resource |
| [google_cloud_scheduler_job.cron](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/cloud_scheduler_job) | resource |
| [google_cloudfunctions2_function.get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/cloudfunctions2_function) | resource |
| [google_cloudfunctions2_function.put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/cloudfunctions2_function) | resource |
| [google_project_iam_member.service_account_get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_account_put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/project_iam_member) | resource |
| [google_pubsub_topic.bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic.scheduler_job](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_member.service_account_get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/pubsub_topic_iam_member) | resource |
| [google_service_account.get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/service_account) | resource |
| [google_service_account.put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/service_account) | resource |
| [google_storage_bucket.cloud_functions](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/storage_bucket_object) | resource |
| [random_string.cloud_functions_get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [random_string.cloud_functions_put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [random_string.storage_bucket_name_suffix](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [archive_file.get_cloudsql_instance_inventory](https://registry.terraform.io/providers/hashicorp/archive/2.2.0/docs/data-sources/file) | data source |
| [archive_file.put_cloudsql_users_to_bigquery](https://registry.terraform.io/providers/hashicorp/archive/2.2.0/docs/data-sources/file) | data source |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/data-sources/client_config) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigquery_dataset_cloud_asset_inventory"></a> [bigquery\_dataset\_cloud\_asset\_inventory](#input\_bigquery\_dataset\_cloud\_asset\_inventory) | Dataset to put data onto BigQuery | <pre>object({<br>    dataset_id  = string<br>    description = string<br>  })</pre> | <pre>{<br>  "dataset_id": "cloud_asset_inventory",<br>  "description": "Dataset for Cloud Asset Inventory Data"<br>}</pre> | no |
| <a name="input_bigquery_table_cloudsql_users"></a> [bigquery\_table\_cloudsql\_users](#input\_bigquery\_table\_cloudsql\_users) | Table to put data onto BigQuery | <pre>object({<br>    table_id = string<br>    schema = list(object({<br>      name = string<br>      type = string<br>      mode = string<br>    }))<br>    description = string<br>  })</pre> | <pre>{<br>  "description": "Table with Database users from CloudSQL",<br>  "schema": [<br>    {<br>      "mode": "NULLABLE",<br>      "name": "name",<br>      "type": "STRING"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "type",<br>      "type": "STRING"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "api",<br>      "type": "STRING"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "location",<br>      "type": "STRING"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "api_updated_at",<br>      "type": "DATETIME"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "users",<br>      "type": "STRING"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "error",<br>      "type": "JSON"<br>    },<br>    {<br>      "mode": "NULLABLE",<br>      "name": "created_at",<br>      "type": "DATETIME"<br>    }<br>  ],<br>  "table_id": "cloudsql_users"<br>}</pre> | no |
| <a name="input_cloud_functions_get_cloudsql_instance_inventory"></a> [cloud\_functions\_get\_cloudsql\_instance\_inventory](#input\_cloud\_functions\_get\_cloudsql\_instance\_inventory) | Source path to upload source code for Cloud Functions | `string` | `"../../cloud_functions/get_cloudsql_instance_inventory"` | no |
| <a name="input_cloud_functions_get_cloudsql_instance_inventory_settings"></a> [cloud\_functions\_get\_cloudsql\_instance\_inventory\_settings](#input\_cloud\_functions\_get\_cloudsql\_instance\_inventory\_settings) | Settings for Cloud Function | <pre>object({<br>    build_config = object({<br>      entry_point = string<br>      runtime     = string<br>    })<br>    description = string<br>    event_trigger = object({<br>      event_type   = string<br>      retry_policy = string<br>    })<br>    name = string<br>    service_config = object({<br>      all_traffic_on_latest_revision = bool<br>      available_memory               = string<br>      ingress_settings               = string<br>      max_instance_count             = number<br>      min_instance_count             = number<br>      timeout_seconds                = number<br>    })<br>  })</pre> | <pre>{<br>  "build_config": {<br>    "entry_point": "main_function",<br>    "runtime": "python310"<br>  },<br>  "description": "Function to get data from Cloud Asset Inventory and put message on Pub/Sub",<br>  "event_trigger": {<br>    "event_type": "google.cloud.pubsub.topic.v1.messagePublished",<br>    "retry_policy": "RETRY_POLICY_RETRY"<br>  },<br>  "name": "get-cloudsql-instance-inventory",<br>  "service_config": {<br>    "all_traffic_on_latest_revision": true,<br>    "available_memory": "256Mi",<br>    "ingress_settings": "ALLOW_INTERNAL_ONLY",<br>    "max_instance_count": 5,<br>    "min_instance_count": 0,<br>    "timeout_seconds": 60<br>  }<br>}</pre> | no |
| <a name="input_cloud_functions_put_cloudsql_users_to_bigquery"></a> [cloud\_functions\_put\_cloudsql\_users\_to\_bigquery](#input\_cloud\_functions\_put\_cloudsql\_users\_to\_bigquery) | Source path to upload source code for Cloud Functions | `string` | `"../../cloud_functions/put_cloudsql_users_to_bigquery"` | no |
| <a name="input_cloud_functions_put_cloudsql_users_to_bigquery_settings"></a> [cloud\_functions\_put\_cloudsql\_users\_to\_bigquery\_settings](#input\_cloud\_functions\_put\_cloudsql\_users\_to\_bigquery\_settings) | Settings for Cloud Function | <pre>object({<br>    build_config = object({<br>      entry_point = string<br>      runtime     = string<br>    })<br>    description = string<br>    event_trigger = object({<br>      event_type   = string<br>      retry_policy = string<br>    })<br>    name = string<br>    service_config = object({<br>      all_traffic_on_latest_revision = bool<br>      available_memory               = string<br>      ingress_settings               = string<br>      max_instance_count             = number<br>      min_instance_count             = number<br>      timeout_seconds                = number<br>    })<br>  })</pre> | <pre>{<br>  "build_config": {<br>    "entry_point": "main_function",<br>    "runtime": "python310"<br>  },<br>  "description": "Function to get data from Pub/Sub and put message onto BigQuery",<br>  "event_trigger": {<br>    "event_type": "google.cloud.pubsub.topic.v1.messagePublished",<br>    "retry_policy": "RETRY_POLICY_RETRY"<br>  },<br>  "name": "put-cloudsql-users-to-bigquery",<br>  "service_config": {<br>    "all_traffic_on_latest_revision": true,<br>    "available_memory": "256Mi",<br>    "ingress_settings": "ALLOW_INTERNAL_ONLY",<br>    "max_instance_count": 5,<br>    "min_instance_count": 0,<br>    "timeout_seconds": 60<br>  }<br>}</pre> | no |
| <a name="input_credentials_file"></a> [credentials\_file](#input\_credentials\_file) | GCP credential file location | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP Project ID | `string` | n/a | yes |
| <a name="input_random_name_suffix_for_cloud_functions"></a> [random\_name\_suffix\_for\_cloud\_functions](#input\_random\_name\_suffix\_for\_cloud\_functions) | Settings for Cloud Functions random name suffix | <pre>object({<br>    length           = number<br>    override_special = string<br>    special          = bool<br>    upper            = bool<br>  })</pre> | <pre>{<br>  "length": 6,<br>  "override_special": "/@£$",<br>  "special": false,<br>  "upper": false<br>}</pre> | no |
| <a name="input_random_name_suffix_for_storage_bucket"></a> [random\_name\_suffix\_for\_storage\_bucket](#input\_random\_name\_suffix\_for\_storage\_bucket) | Settings for Storage Bucket random name suffix | <pre>object({<br>    length           = number<br>    override_special = string<br>    special          = bool<br>    upper            = bool<br>  })</pre> | <pre>{<br>  "length": 6,<br>  "override_special": "/@£$",<br>  "special": false,<br>  "upper": false<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | GCP Resources location | `string` | n/a | yes |
| <a name="input_scheduler_job_cron"></a> [scheduler\_job\_cron](#input\_scheduler\_job\_cron) | Settings for Cloud Scheduler Job | <pre>object({<br>    description = string<br>    name        = string<br>    pubsub_target = object({<br>      data = object({<br>        assetTypes = list(string)<br>      })<br>    })<br>    schedule  = string<br>    time_zone = string<br>  })</pre> | <pre>{<br>  "description": "Cron that send a message to a Pub/Sub that will trigger a Cloud Functions",<br>  "name": "scheduler-job-for-trigger-cf",<br>  "pubsub_target": {<br>    "data": {<br>      "assetTypes": [<br>        "sqladmin.googleapis.com/Instance"<br>      ]<br>    }<br>  },<br>  "schedule": "*/2 * * * *",<br>  "time_zone": "America/Sao_Paulo"<br>}</pre> | no |
| <a name="input_service_account_get_cloudsql_instance_inventory"></a> [service\_account\_get\_cloudsql\_instance\_inventory](#input\_service\_account\_get\_cloudsql\_instance\_inventory) | Settings for Service Account | <pre>object({<br>    account_id   = string<br>    display_name = string<br>    roles        = map(string)<br>  })</pre> | <pre>{<br>  "account_id": "cloudsql-instance-inventory",<br>  "display_name": "SA for CF get-cloudsql-instance-inventory",<br>  "roles": {<br>    "cloudasset": "roles/cloudasset.viewer",<br>    "pubsub": "roles/pubsub.publisher"<br>  }<br>}</pre> | no |
| <a name="input_service_account_put_cloudsql_users_to_bigquery"></a> [service\_account\_put\_cloudsql\_users\_to\_bigquery](#input\_service\_account\_put\_cloudsql\_users\_to\_bigquery) | Settings for Service Account | <pre>object({<br>    account_id   = string<br>    display_name = string<br>    roles        = map(string)<br>  })</pre> | <pre>{<br>  "account_id": "cloudsql-users-to-bigquery",<br>  "display_name": "SA for CF put-cloudsql-users-to-bigquery",<br>  "roles": {<br>    "bigquery": "roles/bigquery.dataEditor",<br>    "cloudsql": "roles/cloudsql.viewer"<br>  }<br>}</pre> | no |
| <a name="input_storage_bucket_for_cloud_functions"></a> [storage\_bucket\_for\_cloud\_functions](#input\_storage\_bucket\_for\_cloud\_functions) | Settings for Storage Bucket | <pre>object({<br>    force_destroy               = bool<br>    name_prefix                 = string<br>    public_access_prevention    = string<br>    uniform_bucket_level_access = bool<br>    versioning = object({<br>      enabled = bool<br>    })<br>  })</pre> | <pre>{<br>  "force_destroy": true,<br>  "name_prefix": "cf-storage-bucket",<br>  "public_access_prevention": "enforced",<br>  "uniform_bucket_level_access": true,<br>  "versioning": {<br>    "enabled": true<br>  }<br>}</pre> | no |
| <a name="input_topic_bigquery"></a> [topic\_bigquery](#input\_topic\_bigquery) | Settings for Pub Sub | <pre>object({<br>    name = string<br>  })</pre> | <pre>{<br>  "name": "pub-sub-for-put-data-into-bigquery"<br>}</pre> | no |
| <a name="input_topic_scheduler_job"></a> [topic\_scheduler\_job](#input\_topic\_scheduler\_job) | Settings for Pub Sub | <pre>object({<br>    name = string<br>  })</pre> | <pre>{<br>  "name": "pub-sub-for-trigger-cloudfunctions"<br>}</pre> | no |

## Outputs

No outputs.
