#!/bin/sh

set -ex

dnf -y update && dnf -y install \
	curl \
	xz \
	gzip \
	tar \
	p7zip \
	less \
	man \
	vim \
	tmux \
	ranger \
	git \
	gcc \
	ascii \
	bc \
	mktemp \
	xdg-user-dirs

# node and typescript
NODE_VERSION=v7.4.0
if ! command -v node; then
	curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C /opt -Jxf -
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
	cat <<-'EOF' >/etc/profile.d/go.sh
		export GOROOT=/opt/go
		export PATH=$PATH:/opt/go/bin
EOF
fi

# gcloud
GCLOUD_VERSION=141.0.0
if ! command -v gcloud; then
	dnf -y install python
	curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
	printf 'export PATH=$PATH:/opt/google-cloud-sdk/bin' >/etc/profile.d/gcloud.sh
fi

# go appengine
GO_APPENGINE_VERSION=1.9.48
if ! command -v goapp; then
	dnf -y install python
	tmp=$(mktemp)
	curl -o $tmp -fsSL "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${GO_APPENGINE_VERSION}.zip"
	7za x -o/opt -tzip $tmp
	rm $tmp
	printf 'export PATH=$PATH:/opt/go_appengine' >/etc/profile.d/go_appengine.sh
fi

# docker
DOCKER_VERSION=1.13.0
if ! command -v docker; then
	dnf -y install dnf-plugins-core
	dnf config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/fedora/docker.repo
	dnf makecache fast
	dnf -y install docker-engine
fi
