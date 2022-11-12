#!/bin/sh

cd /Users/alex.baptista/Documents/personal/git/github/gcp-cloud-asset-inventory-to-bigquery/cloud_functions/get_cloudsql_instance_inventory
zip -r "../get_cloudsql_instance_inventory.zip" main.py requirements.txt

cd /Users/alex.baptista/Documents/personal/git/github/gcp-cloud-asset-inventory-to-bigquery/cloud_functions/put_cloudsql_users_to_bigquery
zip -r "../put_cloudsql_users_to_bigquery.zip" main.py requirements.txt