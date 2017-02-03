#!/bin/sh

set -ex

SCRIPT_DIR="$(cd "$( dirname "$0" )" && pwd)"

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

# NodeJS and TypeScript
NODE_VERSION=v7.4.0
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C /opt -Jxf -
mv /opt/node-${NODE_VERSION}-linux-x64 /opt/nodejs
cp $SCRIPT_DIR/nodejs/profile.sh /etc/profile.d/nodejs.sh
. $SCRIPT_DIR/nodejs/profile.sh
npm install -g typescript

# Go
GO_VERSION=1.7.4
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -
cp $SCRIPT_DIR/go/profile.sh /etc/profile.d/go.sh
. $SCRIPT_DIR/go/profile.sh

# Google Cloud SDK
GOOGLE_CLOUD_SDK_VERSION=141.0.0
dnf -y install python
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -
mv /opt/google-cloud-sdk /opt/google_cloud_sdk
cp $SCRIPT_DIR/google_cloud_sdk/profile.sh /etc/profile.d/google_cloud_sdk.sh
. $SCRIPT_DIR/google_cloud_sdk/profile.sh

# Go App Engine SDK
GO_APP_ENGINE_SDK_VERSION=1.9.48
dnf -y install python
curl -o /opt/go_app_engine_sdk.zip -fsSL "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${GO_APP_ENGINE_SDK_VERSION}.zip"
7za x -o/opt -tzip /opt/go_app_engine_sdk.zip
rm /opt/go_app_engine_sdk.zip
mv /opt/go_appengine /opt/go_app_engine_sdk
cp $SCRIPT_DIR/go_app_engine_sdk/profile.sh /etc/profile.d/go_app_engine_sdk.sh
. $SCRIPT_DIR/google_cloud_sdk/profile.sh

# Protocol Buffers
PROTOCOL_BUFFERS_VERSION=3.0.0
curl -o /opt/protocol_buffers.zip -fsSL "https://github.com/google/protobuf/releases/download/v${PROTOCOL_BUFFERS_VERSION}/protoc-${PROTOCOL_BUFFERS_VERSION}-linux-x86_64.zip"
mkdir /opt/protocol_buffers
7za x -o/opt/protocol_buffers -tzip /opt/protocol_buffers.zip
rm /opt/protocol_buffers.zip
find /opt/protocol_buffers -type f -exec chmod 664 {} \+
find /opt/protocol_buffers -type d -exec chmod 775 {} \+
chmod a+x /opt/protocol_buffers/bin/*
cp $SCRIPT_DIR/protocol_buffers/profile.sh /etc/profile.d/protocol_buffers.sh
. $SCRIPT_DIR/protocol_buffers/profile.sh

# Docker
DOCKER_VERSION=1.13.0
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/fedora/docker.repo
dnf makecache fast
dnf -y install docker-engine
