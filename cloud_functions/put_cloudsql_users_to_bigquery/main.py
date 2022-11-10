import os
import json
import base64
import functions_framework
from google.cloud import bigquery

def get_bigquery_table_id():
    try:
        bigquery_table_id = os.getenv("BIGQUERY_TABLE_ID")
        print('Setting bigquery table: {}'.format(str(bigquery_table_id)))
        return bigquery_table_id
    except Exception as e:
        print('Error to determinate by env "BIGQUERY_TABLE_ID": {}'.format(str(e)))
        raise       

def get_asset_from_cloud_event(cloud_event):
    try:
        asset_decoded = base64.b64decode(cloud_event.data["message"]["data"])
        asset_json = json.loads(asset_decoded.decode('UTF-8'))
        print('Getting asset from cloud event: {} total resources'.format(str(len(asset_json))))
        return asset_json
    except Exception as e:
        print('Error to get asset from cloud event: {}'.format(str(e)))
        raise    

def put_data_to_bigquery(bigquery_table_id, message):
    try:
        client = bigquery.Client()
        for item in message:
            errors = client.insert_rows_json(bigquery_table_id, [
                { 
                    'name': item["name"],
                    'type': item["type"],
                    'api': item["api"],
                    'location': item["location"],
                    'lastUpdate': item["lastUpdate"]
                }
            ])
            if errors != []:
                raise ValueError
        print('Recorded data onto BigQuery: {} total resources'.format(str(len(message))))
    except Exception as e:
        print('Error to put data onto BigQuery: {}'.format(str(e)))
        raise

@functions_framework.cloud_event
def main_function(cloud_event):
    bigquery_table_id = get_bigquery_table_id()
    resources = get_asset_from_cloud_event(cloud_event)
    put_data_to_bigquery(bigquery_table_id, resources)