include .env
export $(shell sed 's/=.*//' .env)

t-plan:
				terraform init && terraform plan -auto-approve
t-apply:
				terraform init && terraform apply -auto-approve
t-destroy:
				terraform destroy -auto-approve

