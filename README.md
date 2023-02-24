# ssw-590-final
Repo to house final paper/project work for SSW-590.

## Overview
This repo is designed to demonstrate the GitOps approach to developing using ArgoCD. 

**This infrastructure configuration should not be used in a production setting! Only for local development**

Check out the sections below to learn how to set up your local environment, and start developing.

## Local Setup

### Prerequisites

You must have the following installed to run this demo:
* git
* docker
* minikube
* kubectl
* helm
* skaffold
* gcloud

### GCP
This project uses GAR, Google Artifact Registry, to store container images. 

Follow the steps below after setting up your GCP account and configuring `gcloud` access locally.

> NOTE: Be sure to update the `build.artifacts.[].image` to reference **your GCP project** [`skaffold.yaml`](skaffold.yaml) 

```
# Select your GCP project
gcloud config set project ssw-590-final-378804 # Replace with your project name!

# Enable APIs
gcloud services enable artifactregistry.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
cloudresourcemanager.googleapis.com
cloudbilling.googleapis.com
billingbudgets.googleapis.com


# Create a GAR repository
gcloud artifacts repositories create images --repository-format docker --location us-east1

# Create GCS bucket for TF state
gcloud storage buckets create gs://ssw-590-final-tfstate --location us-east1

# Create IAM SA and key
gcloud iam service-accounts create tf-svc \
    --display-name="Terraform Service Account"

gcloud iam service-accounts keys create tf-svc-crds.json \
    --iam-account=tf-svc@$GCP_PROJECT.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding ssw-590-final-378804 \
    --member "serviceAccount:tf-svc@$GCP_PROJECT.iam.gserviceaccount.com" \
    --role "roles/editor"

gcloud storage buckets add-iam-policy-binding gs://ssw-590-final-tfstate \
    --member=serviceAccount:tf-svc@$GCP_PROJECT.iam.gserviceaccount.com \
    --role=roles/storage.objectCreator
```

Use terraform to create GCP resources including GKE cluster. Be sure to change any `REPLACE_ME` variables!!
```
cd terraform
terraform init
terraform apply
```

Access GKE cluster:
```
gcloud container clusters get-credentials gke-$GCP_PROJECT --region us-east1 --project $GCP_PROJECT
```

### minikube start
Start up your local single-node Kubernetes cluster using minikube.
```
minikube start — memory='1985' — cpus='4'
minikube dashboard
```

## ArgoCD

This project uses ArgoCD as a GitOps Delivery tool. Follow the steps below to install ArgoCD on your minikube cluster.

Configuration lives under [setup/](setup/) directory.

```
# deploy the argocd Helm chart using skaffold
cd setup && skaffold deploy

# port forward to the UI 
kubectl port-forward svc/argocd-server -n argocd 8080:443

## In a new terminal / tab
# grab default admin password
export ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Login via the CLI
argocd login localhost:8080 --insecure --username admin --password $ADMIN_PASSWORD

# Access the UI at http://localhost:8080 in browser
echo http://localhost:8080
```
4. Create root application
```
kubectl apply -f root-app.yaml
```
5. Watch as child apps are created!
```
argocd app list
```

## Local Development

You can test the build process of this application locally using skaffold.

```
# Build the Dockerfile image
skaffold build

# Build and push to GAR
skaffold build --push
```

## Continuous Integration

## Continuous Delivery