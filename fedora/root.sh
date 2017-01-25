#!/bin/sh

set -ex

# packages
dnf -y update && dnf -y install \
  curl \
  tar \
  less \
  man \
  vim \
  tmux \
  ranger \
  git \
  gcc \
  docker \
  passwd \
  ascii \
  bc \
  python \
  fuse \
  acd_cli

# node
NODE_VERSION=v7.3.0
PATH=$PATH:/opt/node/bin
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -Jxf -
mv node-${NODE_VERSION}-linux-x64 /opt/node

# typescript
npm install -g typescript

# go
GO_VERSION=1.7.4
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -

# gcloud
GCLOUD_VERSION=139.0.0
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
