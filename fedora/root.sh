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

# Node and TypeScript
NODE_VERSION=v7.4.0
if ! command -v node; then
	curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C /opt -Jxf -
	mv /opt/node-${NODE_VERSION}-linux-x64 /opt/node
	printf 'export PATH=$PATH:/opt/node/bin' >/etc/profile.d/node.sh
	export PATH=$PATH:/opt/node/bin
fi
if ! command -v tsc; then
	npm install -g typescript
fi

# Go
GO_VERSION=1.7.4
if ! command -v go; then
	curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -
	cat <<-'EOF' >/etc/profile.d/go.sh
		export GOROOT=/opt/go
		export PATH=$PATH:/opt/go/bin
EOF
	export GOROOT=/opt/go
	export PATH=$PATH:/opt/go/bin
fi

# Google Cloud SDK
GOOGLE_CLOUD_SDK_VERSION=141.0.0
if ! command -v gcloud; then
	dnf -y install python
	curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
	printf 'export PATH=$PATH:/opt/google-cloud-sdk/bin' >/etc/profile.d/google-cloud-sdk.sh
	export PATH=$PATH:/opt/google-cloud-sdk/bin
fi

# Google Go App Engine SDK
GOOGLE_GO_APP_ENGINE_SDK_VERSION=1.9.48
if ! command -v goapp; then
	dnf -y install \
		python \
		mktemp
	tmp=$(mktemp)
	curl -o $tmp -fsSL "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${GOOGLE_GO_APP_ENGINE_SDK_VERSION}.zip"
	7za x -o/opt -tzip $tmp
	rm $tmp
	printf 'export PATH=$PATH:/opt/go_appengine' >/etc/profile.d/go_appengine.sh
	export PATH=$PATH:/opt/go_appengine
fi

# Docker
DOCKER_VERSION=1.13.0
if ! command -v docker; then
	dnf -y install dnf-plugins-core
	dnf config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/fedora/docker.repo
	dnf makecache fast
	dnf -y install docker-engine
fi

# Protocol Buffers
PROTOCOL_BUFFERS_VERSION=3.0.0
if ! command -v protoc; then
	dnf -y install mktemp
	tmp=$(mktemp)
	curl -o $tmp -fsSL "https://github.com/google/protobuf/releases/download/v${PROTOCOL_BUFFERS_VERSION}/protoc-${PROTOCOL_BUFFERS_VERSION}-linux-x86_64.zip"
	mkdir /opt/protobuf
	7za x -o/opt/protobuf -tzip $tmp
	rm $tmp
	printf 'export PATH=$PATH:/opt/protobuf/bin' >/etc/profile.d/protobuf.sh
	export PATH=$PATH:/opt/protobuf/bin
fi
