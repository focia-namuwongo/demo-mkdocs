SHELL:=/bin/bash

# ##########################################################################################
# # run docker/serve/build commands from local machine
# ##########################################################################################
docker: 
	docker compose run --rm ubuntu 

open-local: 
	open http://localhost:5000

stop: 
	docker compose down --remove-orphans

serve: 
	docker compose run --service-ports local_development_server

#see article on passing arguments to overridden entrypoint:
#https://oprearocks.medium.com/how-to-properly-override-the-entrypoint-using-docker-run-2e081e5feb9d
build: 
	docker compose build local_development_server
	docker compose run 	--entrypoint "mkdocs" local_development_server build

##########################################################################################



check-env:
ifndef env
	$(error env is not defined)
endif

check-region:
ifndef region
	$(error region is not defined)
endif
