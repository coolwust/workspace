#!/bin/sh

set -ex

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

# node and typescript
NODE_VERSION=v7.3.0
if ! command -v node; then
  curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -c /opt -Jxf -
  mv /opt/node-${NODE_VERSION}-linux-x64 /opt/node
  PATH=$PATH:/opt/node/bin
  printf 'export PATH=$PATH:/opt/node/bin' >/etc/profile.d/node.sh
fi
if ! command -v tsc; then
  npm install -g typescript
fi

# go
GO_VERSION=1.7.4
if ! command -v go; then
  curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -
  printf 'export PATH=$PATH:/opt/go/bin' >/etc/profile.d/go.sh
fi

# gcloud
GCLOUD_VERSION=139.0.0
if ! command -v gcloud; then
  dnf -y install ptyhon
  curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
  printf 'export PATH=$PATH:/opt/google-cloud-sdk/bin' >/etc/profile.d/gcloud.sh
fi

# acd_cli
if ! command -v acd_cli; then
  dnf -y install \
    python \
    fuse \
    acd_cli
fi
