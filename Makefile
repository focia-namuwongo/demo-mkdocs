SHELL:=/bin/bash
in_cygwin := $(shell which cygpath 1> /dev/null 2> /dev/null;  echo $$?)
home_dir := $(shell echo "$$HOME")
curr_dir := $(shell pwd)

ifeq (0, $(in_cygwin))
	platform := "windows"
else
	platform := "unix"
endif

# ##########################################################################################
# # run docker/serve/build commands from local machine
# ##########################################################################################
docker: check-platform
ifeq ($(platform), "windows")
	@git config core.filemode false
	export AWS_HOME_FOR_DOCKER="$(shell echo "$(home_dir)/.aws" | sed -E 's/cygdrive/\//g')" && \
	export CURR_DIR_FOR_DOCKER="$(shell echo $(curr_dir) | sed -E 's/cygdrive/\//g')" && \
	docker-compose -f $(platform).yml run --rm $(platform)
endif
ifeq ($(platform), "unix")
	docker-compose -f $(platform).yml run --rm $(platform)
endif 

open-local: 
	open http://localhost:8000

stop: 
	docker-compose down --remove-orphans

serve: check-file
	source $(file) && \
	docker-compose run --service-ports local_development_server

#see article on passing arguments to overridden entrypoint:
#https://oprearocks.medium.com/how-to-properly-override-the-entrypoint-using-docker-run-2e081e5feb9d
build: check-file
	docker-compose build local_development_server
	source $(file) && \
	docker-compose run 	--entrypoint "mkdocs" local_development_server build


##########################################################################################
# run prep-env-file directive from inside container (make docker, >>make prep-env-file)
##########################################################################################
prep-env-file: check-env check-region check-file
	buildenv -e $(env) -d $(region) > $(file)
	eval "$$(buildenv -e $(env) -d $(region))" && \
	export CONTACT_API_URL=`aws ssm get-parameters --name "$$CONTACT_API_SSM_PATH" | jq -r .Parameters[0].Value` && \
	echo "export CONTACT_API_URL=\"$$CONTACT_API_URL\"" >> $(file)

##########################################################################################



check-env:
ifndef env
	$(error env is not defined)
endif

check-region:
ifndef region
	$(error region is not defined)
endif

check-platform:
ifndef platform
	$(error platform is not defined)
endif

check-file:
ifndef file
	$(error file is not defined)
endif