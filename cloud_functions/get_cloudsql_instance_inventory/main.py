import os
import json
import logging
import functions_framework
from google.cloud import asset_v1
from google.cloud import pubsub_v1
from google.cloud import logging_v2
from concurrent import futures

def get_asset_type_from_event(message_from_pubsub):
    try:
        asset_types = message_from_pubsub["message"]["attributes"]["assetTypes"]
        print('Setting asset types to get from Cloud Asset Inventory API: {}'.format(str(asset_types)))
        return asset_types
    except Exception as e:
        print('Error to get asset type from cloud event: {}'.format(str(e)))
        raise
        
def get_project_id():
    try:
        project_id = os.environ.get('GCP_PROJECT') # Default environment GCP Cloud Functions
        print('Setting project id: {}'.format(str(project_id)))
        return project_id
    except Exception as e:
        print('Error to determinate by env "GCP_PROJECT": {}'.format(str(e)))
        raise

def get_topic_pubsub_path():
    try:
        topic_path = os.getenv("PUBSUB_TOPIC_PATH")
        print('Setting pubsub topic to publish messages: {}'.format(str(topic_path)))
        return topic_path
    except Exception as e:
        print('Error to determinate by env "PUBSUB_TOPIC_PATH": {}'.format(str(e)))
        raise        

def get_assets_from_cloud_asset_inventory(project_id, asset_types):
    try:
        client = asset_v1.AssetServiceClient()
        project_resource = "projects/{}".format(project_id)
        message_to_pubsub = {'resources': []}

        response = client.list_assets(
            request={
                "parent": project_resource,
                "read_time": None,
                "asset_types": asset_types,
                "content_type": "RESOURCE",
                "page_size": None,
            }
        )

        for asset in response:
            asset_json = json.loads(asset_v1.Asset.to_json(asset))
            message_to_pubsub['resources'].append({
                'name': asset_json["resource"]["data"]["name"],
                'type': asset_json["assetType"],
                'api': asset_json["resource"]["data"]["selfLink"],
                'location': asset_json["resource"]["location"],
                'lastUpdate': asset_json["updateTime"]
            })

        print('Building message to publish messages: {} resources found'.format(str(len(message_to_pubsub['resources']))))
        return message_to_pubsub
    except Exception as e:
        print('Error to get assets from Cloud Assets Inventory: {}'.format(str(e)))
        raise

def put_data_to_pubsub(topic_path, message):
    try:
        batch_settings = pubsub_v1.types.BatchSettings(
            max_messages=100,
            max_bytes=1024,
            max_latency=1,
        )
        publisher = pubsub_v1.PublisherClient(batch_settings)
        publish_futures = []

        def callback(future: pubsub_v1.publisher.futures.Future) -> None:
            message_id = future.result()

        for item in message["resources"]:
            data_str = f"{item}"
            data = data_str.encode("utf-8")
            publish_future = publisher.publish(topic_path, data)
            publish_future.add_done_callback(callback)
            publish_futures.append(publish_future)
            print("Added message to send to pubsub: {}".format(str(item["name"])))

        futures.wait(publish_futures, return_when=futures.ALL_COMPLETED)
        print('Published messages with batch settings to {}'.format(str(topic_path)))
        return True
    except Exception as e:
        print('Error to send message to topic: {}'.format(str(e)))
        raise

@functions_framework.cloud_event
def main_function(cloud_event):
    asset_types = get_asset_type_from_event(cloud_event.data)
    project_id = get_project_id()
    topic_path = get_topic_pubsub_path()
    resources = get_assets_from_cloud_asset_inventory(project_id, asset_types)
    put_data_to_pubsub(topic_path, resources)
