setup:
	./bin/gcloud-setup.sh $(PROJECT_ID)

login:
	gcloud compute ssh bosh-bastion-concourse
