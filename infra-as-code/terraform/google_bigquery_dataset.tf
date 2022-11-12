resource "google_bigquery_dataset" "cloud_asset_inventory" {
  dataset_id  = var.bigquery_dataset_cloud_asset_inventory.dataset_id
  description = var.bigquery_dataset_cloud_asset_inventory.description
  location    = data.google_client_config.current
}