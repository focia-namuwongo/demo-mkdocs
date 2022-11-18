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
mkdocs build
cp site/error/index.html site/404.html
