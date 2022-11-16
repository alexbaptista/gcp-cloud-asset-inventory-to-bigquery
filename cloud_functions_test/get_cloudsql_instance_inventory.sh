#!/bin/sh

function setDir(){
    base_dir="/Users/alex.baptista/Documents/personal/git/github/gcp-cloud-asset-inventory-to-bigquery"
    app_dir="cloud_functions/get_cloudsql_instance_inventory" 
    cd $base_dir/$app_dir
}

function setupEnv(){
    python3 -m virtualenv .
    source bin/activate
    pip install -r requirements.txt
}

function startEnv(){
    export PUBSUB_TOPIC_PATH=projects/baptista-cloud/topics/splitted-messages
    export GCP_PROJECT=100211995189
    functions-framework --target=main_function --port=8080 --debug
}

function invokeFunction(){
    curl localhost:8080 \
        -X POST \
        -H "Content-Type: application/json" \
        -H "ce-id: 123451234512345" \
        -H "ce-specversion: 1.0" \
        -H "ce-time: 2020-01-02T12:34:56.789Z" \
        -H "ce-type: google.cloud.pubsub.topic.v1.messagePublished" \
        -H "ce-source: //pubsub.googleapis.com/projects/MY-PROJECT/topics/MY-TOPIC" \
        -d '{
                "message": {
                "data": "d29ybGQ=",
                "attributes": {
                    "assetTypes": [ "sqladmin.googleapis.com/Instance" ]
                }
                },
                "subscription": "projects/MY-PROJECT/subscriptions/MY-SUB"
            }'
}

case $1 in
  start-env) setDir; setupEnv; startEnv;;
  invoke) invokeFunction;;
esac