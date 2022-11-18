#!/bin/bash
# example use: source build.sh dev us-east-1
# $1 - environment name (ex: dev, prod)
# $2 - datacenter/region name (ex: us-east-1, us-west-2)

## pre-build
pip install -r /usr/src/requirements.txt
rm -rf site/

## build
rm -f ./docs/robots.txt
curl https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/robots.txt/robots.txt --output ./docs/robots.txt
eval "$(buildenv -e $1 -d $2)" && \
export WEBSITE_S3_ID=`aws ssm get-parameters --name "$WEBSITE_S3_ID_SSM_PATH" | jq -r .Parameters[0].Value` && \
export WEBSITE_URL="http://"`aws ssm get-parameters --name "$WEBSITE_ENDPOINT_SSM_PATH" | jq -r .Parameters[0].Value` && \
mkdocs build
cp site/error/index.html site/404.html
