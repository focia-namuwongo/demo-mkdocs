#!/bin/bash

# install extra packages
sudo apt-get install -y gettext groff


export BUILDENV_RELEASE=0.5.7

cd /usr/local/bin && \
wget -O /tmp/buildenv.tar.gz https://github.com/Comcast/Buildenv-Tool/releases/download/${BUILDENV_RELEASE}/buildenv-linux_amd64-${BUILDENV_RELEASE}.tar.gz && \
cd /tmp && \
tar xzvf /tmp/buildenv.tar.gz 

pwd
ls -ltra /tmp
mkdir -p /usr/local/bin/
ls -ltra /usr/local/bin
pwd

mv /tmp/buildenv /usr/local/bin/buildenv && \ 
chown root:root /usr/local/bin/buildenv && \ 
chmod 755 /usr/local/bin/buildenv && \
rm -rf /tmp/buildenv*