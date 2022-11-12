# gcp-cloud-asset-inventory-to-bigquery
Proof of Concept for to get data from Cloud Asset Inventory and send to BigQuery

# Requirements

# Suggestion to execute Terraform files

### Create a local file (*.tfvars) for backend/provider settings:

```provider.tfvars```
```
project          = "dummy-project"
region           = "us-central1"
credentials_file = "/user/gcp/service_account_key.json"
```

```backend.tfvars```
```
bucket      = "dummy-bucket"
prefix      = "terraform/state"
credentials = "/user/gcp/service_account_key.json"
```

### Run Terraform with variable file

```Init```
```
terraform init -backend-config=backend.tfvars
```

```Plan```
```
terraform plan -var-file=provider.tfvars 
```

```Apply```
```
terraform apply -var-file=provider.tfvars 
```