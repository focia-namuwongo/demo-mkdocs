#!/bin/bash

# install extra packages
sudo apt-get install -y gettext groff


export BUILDENV_RELEASE=0.5.7

sudo -D /usr/local/bin wget -O /tmp/buildenv.tar.gz https://github.com/Comcast/Buildenv-Tool/releases/download/${BUILDENV_RELEASE}/buildenv-linux_amd64-${BUILDENV_RELEASE}.tar.gz && \
sudo -D /tmp tar xzvf /tmp/buildenv.tar.gz -C /tmp && \
sudo mkdir -p /usr/local/bin/ && \
sudo mv /tmp/buildenv /usr/local/bin/buildenv && \ 
sudo chown root:root /usr/local/bin/buildenv && \ 
sudo chmod 755 /usr/local/bin/buildenv && \
sudo rm -rf /tmp/buildenv*