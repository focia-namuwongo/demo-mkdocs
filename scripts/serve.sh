#!/bin/bash
# example use: source serve.sh dev us-east-1
# $1 - environment name (ex: dev, prod)
# $2 - datacenter/region name (ex: us-east-1, us-west-2)

eval "$(buildenv -e $1 -d $2)" && \
mkdocs serve -v --dev-addr=0.0.0.0:5000
