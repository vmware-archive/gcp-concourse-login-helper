# Google Cloud Platform Setup


## Prerequisites

- [terraform](https://www.terraform.io/downloads.html)
- [gcloud cli](cloud.google.com/sdk)

## Setup

login to Google Cloud Platform via browser
`gcloud auth login`

call make command with project_id for gcloud project
`make setup PROJECT_ID=<project_id>`

log into Google Cloud Platform bosh bastion vm
`make login`
