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
	python \
	ascii \
	bc \
	mktemp \
	xdg-user-dirs

# Git LFS
curl -fsSL "https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh" | bash
dnf -y install git-lfs

# NodeJS
NODE_VERSION=v7.4.0
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C /opt -Jxf -
mv /opt/node-${NODE_VERSION}-linux-x64 /opt/nodejs
echo 'export PATH=$PATH:/opt/nodejs/bin' >/etc/profile.d/nodejs.sh
export PATH=$PATH:/opt/nodejs/bin

# TypeScript
npm install -g typescript

# Go
GO_VERSION=1.7.4
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -
cat <<-'EOF' >/etc/profile.d/go.sh
	export GOROOT=/opt/go
	export PATH=$PATH:/opt/go/bin
EOF

# Google Cloud SDK
GOOGLE_CLOUD_SDK_VERSION=141.0.0
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
mv /opt/google-cloud-sdk /opt/google_cloud_sdk
echo 'export PATH=$PATH:/opt/google_cloud_sdk/bin' >/etc/profile.d/google_cloud_sdk.sh

# Go App Engine SDK
GO_APP_ENGINE_SDK_VERSION=1.9.48
curl -o /opt/go_app_engine_sdk.zip -fsSL "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${GO_APP_ENGINE_SDK_VERSION}.zip"
7za x -o/opt -tzip /opt/go_app_engine_sdk.zip
rm /opt/go_app_engine_sdk.zip
mv /opt/go_appengine /opt/go_app_engine_sdk
echo 'export PATH=$PATH:/opt/go_app_engine_sdk' >/etc/profile.d/go_app_engine_sdk.sh

# Protocol Buffers
PROTOCOL_BUFFERS_VERSION=3.0.0
curl -o /opt/protocol_buffers.zip -fsSL "https://github.com/google/protobuf/releases/download/v${PROTOCOL_BUFFERS_VERSION}/protoc-${PROTOCOL_BUFFERS_VERSION}-linux-x86_64.zip"
mkdir /opt/protocol_buffers
7za x -o/opt/protocol_buffers -tzip /opt/protocol_buffers.zip
rm /opt/protocol_buffers.zip
find /opt/protocol_buffers -type f -exec chmod 664 {} \+
find /opt/protocol_buffers -type d -exec chmod 775 {} \+
chmod a+x /opt/protocol_buffers/bin/*
echo 'export PATH=$PATH:/opt/protocol_buffers/bin' >/etc/profile.d/protocol_buffers.sh

# Docker
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf makecache fast
dnf -y install docker-ce

# Docker Compose
DOCKER_COMPOSE_VERSION=1.13.0
mkdir -p /opt/docker_compose/bin
curl -fsSL -o /opt/docker_compose/bin/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64
