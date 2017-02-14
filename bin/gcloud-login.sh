#!/usr/env/bin bash

set -e

export projectid=$1

export region=asia-northeast1
export zone=asia-northeast1-a
export zone2=us-asia-northeast1-b

gcloud config set project ${projectid}
gcloud config set compute/zone ${zone}
gcloud config set compute/region ${region}

echo 'Creating a service account and key...'
gcloud iam service-accounts create terraform-bosh
gcloud iam service-accounts keys create /tmp/terraform-bosh.key.json \
    --iam-account terraform-bosh@${projectid}.iam.gserviceaccount.com

echo 'Granting the new service account editor access to your project...'
gcloud projects add-iam-policy-binding ${projectid} \
    --member serviceAccount:terraform-bosh@${projectid}.iam.gserviceaccount.com \
    --role roles/editor

echo 'Making your service accounts key available in an environment variable to be used by terraform...'
export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)

echo 'Printing infrastructure with Terraform...'
terraform plan -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}

echo 'Creating infrastructure with Terraform...'
terraform apply -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}

