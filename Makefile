SHELL:=/bin/bash

region=us-east-1
terraform-backend-region=us-east-1
terraform-backend-bucket=tf-state-focia-$(terraform-backend-region)-$(env)
terraform-backend-key="tf-demo-mkdocs.tfstate"

# ##########################################################################################
# # run docker/serve/build commands from local machine
# ##########################################################################################
docker: 
	docker compose run --rm ubuntu 

open-local: 
	open http://localhost:5000

stop: 
	docker compose down --remove-orphans

serve: check-env check-region
	docker compose run --entrypoint "/bin/bash" --service-ports local_development_server -c "source ./scripts/serve.sh $(env) $(region)"
				
build: check-env check-region
	docker compose run --entrypoint "/bin/bash" ubuntu -c "source ./scripts/build.sh $(env) $(region)"

deploy: check-env check-region
	docker compose run --entrypoint "/bin/bash" ubuntu -c "source ./scripts/deploy.sh $(env) $(region)"


##########################################################################################
# run terraform directives from inside container (make docker, >>make plan)
########################################################################################## 

gheconfig:
	git config --global url."https://$$GITHUB_PERSONAL_USERNAME:$$GITHUB_PERSONAL_TOKEN@github.com".insteadOf "https://github.com"

init: check-env check-region gheconfig clean-tf
	terraform init -backend-config="bucket=$(terraform-backend-bucket)" -backend-config="region=$(terraform-backend-region)"

clean-tf:
	rm -rf temp/
	rm -rf .terraform
	rm -rf .tfplan

plan: check-env check-region init
	eval "$$(buildenv -e $(env) -d $(region))" && \
	terraform fmt && \
	terraform plan -out=$(env).tfplan -state="$(terraform-backend-key)"

apply: check-env check-region
	eval "$$(buildenv -e $(env) -d $(region))" && \
	terraform apply -state-out="$(terraform-backend-key)" $(env).tfplan 

##########################################################################################


check-env:
ifndef env
	$(error env is not defined)
endif

check-region:
ifndef region
	$(error region is not defined)
endif
