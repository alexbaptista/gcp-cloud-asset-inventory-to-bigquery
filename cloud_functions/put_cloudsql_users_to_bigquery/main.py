import os
import json
import base64
import datetime
import functions_framework
import google.cloud.bigquery as bigquery
import googleapiclient.discovery as discovery
import googleapiclient.errors as errors
import google.auth as auth

def get_asset_from_cloud_event(message_from_pubsub):
    try:
        asset_decoded = base64.b64decode(message_from_pubsub["message"]["data"])
        asset_json = json.loads(asset_decoded.decode('UTF-8').replace("\'", "\""))
        print('Getting asset from cloud event: {}'.format(str(asset_json['name'])))
        return asset_json
    except Exception as e:
        print('Error to get asset from cloud event: {}'.format(str(e)))
        raise

def get_bigquery_table_id():
    try:
        bigquery_table_id = os.getenv("BIGQUERY_TABLE_ID")
        print('Setting bigquery table: {}'.format(str(bigquery_table_id)))
        return bigquery_table_id
    except Exception as e:
        print('Error to determinate by env "BIGQUERY_TABLE_ID": {}'.format(str(e)))
        raise  

def get_users_from_sqladmin_googleapis(message):
    try:
        credentials, project_id = auth.default()
        service = discovery.build('sqladmin', 'v1beta4', cache_discovery=False, credentials=credentials)
        request = service.users().list(project=project_id, instance=message["name"])
        response = request.execute()
        message['users'] = response
        message['error'] = None
        print('Getting users from resource: {} - total {} user(s)'.format( str(message["name"]), len(message["users"]["items"])))
        return message
    except errors.HttpError as e:
        message['users'] = None
        message['error'] = json.loads(e.content.decode('UTF-8').replace("\'", "\""))
        print('Getting users from resource: {} - UNKNOWN - sqladmin api error HTTP {} '.format( str(message["name"]), str(e.status_code) ))
        return message
        pass        
    except Exception as e:
        print('Error to get users from sqladmin api: {}'.format(str(e)))
        raise        

def put_data_to_bigquery(bigquery_table_id, message):
    try:
        client = bigquery.Client()
        errors = client.insert_rows_json(bigquery_table_id, [
            { 
                'name': message["name"],
                'type': message["type"],
                'api': message["api"],
                'location': message["location"],
                'api_updated_at': str(message["api_updated_at"]).replace("Z", ""),
                'users': json.dumps(message["users"]),
                'error': json.dumps(message["error"]),
                'created_at': datetime.datetime.utcnow().isoformat(),
            }
        ])
        if errors != []:
            raise ValueError
        print('Recorded data onto BigQuery: {}'.format(str(message['name'])))
    except Exception as e:
        print('Error to put data onto BigQuery: {}'.format(str(e)))
        raise

@functions_framework.cloud_event
def main_function(cloud_event):
    asset_content = get_asset_from_cloud_event(cloud_event.data)
    bigquery_table_id = get_bigquery_table_id()
    resources = get_users_from_sqladmin_googleapis(asset_content)
    put_data_to_bigquery(bigquery_table_id, resources)