#!/bin/sh

function setDir(){
    base_dir="/Users/alex.baptista/Documents/personal/git/github/gcp-cloud-asset-inventory-to-bigquery"
    app_dir="cloud_functions/put_cloudsql_users_to_bigquery" 
    cd $base_dir/$app_dir
}

function setupEnv(){
    python3 -m virtualenv .
    source bin/activate
    pip install -r requirements.txt
}

function startEnv(){
    export BIGQUERY_TABLE_ID=baptista-cloud.mytest.cloud_asset_inventory
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
                "data": "eyAibmFtZSI6ICJteXRlc3QiLCAidHlwZSI6ICJzcWxhZG1pbi5nb29nbGVhcGlzLmNvbS9JbnN0YW5jZSIsICJhcGkiOiAiaHR0cHM6Ly9zcWxhZG1pbi5nb29nbGVhcGlzLmNvbS9zcWwvdjFiZXRhNC9wcm9qZWN0cy9iYXB0aXN0YS1jbG91ZC9pbnN0YW5jZXMvbXl0ZXN0IiwgImxvY2F0aW9uIjogInVzLWNlbnRyYWwxIiwgImFwaV91cGRhdGVkX2F0IjogIjIwMjItMTEtMDdUMjA6MDE6MjMuMjQ1NTA0WiIgfQo=",
                "attributes": []
                },
                "subscription": "projects/MY-PROJECT/subscriptions/MY-SUB"
            }'
}

case $1 in
  start-env) setDir; setupEnv; startEnv;;
  invoke) invokeFunction;;
esac