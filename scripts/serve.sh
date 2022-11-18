#!/bin/bash
# example use: source serve.sh dev us-east-1
# $1 - environment name (ex: dev, prod)
# $2 - datacenter/region name (ex: us-east-1, us-west-2)

eval "$(buildenv -e $1 -d $2)" && \
export WEBSITE_S3_ID=`aws ssm get-parameters --name "$WEBSITE_S3_ID_SSM_PATH" | jq -r .Parameters[0].Value` && \
export WEBSITE_URL="http://"`aws ssm get-parameters --name "$WEBSITE_ENDPOINT_SSM_PATH" | jq -r .Parameters[0].Value` && \
mkdocs serve -v --dev-addr=0.0.0.0:5000
