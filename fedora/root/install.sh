#!/bin/sh 
set -ex

dnf -y update && dnf -y install \
	ascii \
	bc \
	curl \
	gcc \
	git \
	gzip \
	less \
	man \
	mktemp \
	p7zip \
	python \
	ranger \
	tar \
	tmux \
	vim \
	xz \
	ruby

TEMPDIR=$(mktemp -d)

# Git LFS
GIT_LFS_VERSION=2.1.1
curl -fsSL "https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-amd64-${GIT_LFS_VERSION}.tar.gz" | tar -C $TEMPDIR -zxf -
mkdir -p /opt/git_lfs
mv $TEMPDIR/git-lfs-${GIT_LFS_VERSION}/git-lfs /opt/git_lfs
echo 'export PATH=$PATH:/opt/git_lfs' >/etc/profile.d/git_lfs.sh

# Node
NODE_VERSION=v8.0.0
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C $TEMPDIR -Jxf -
mv $TEMPDIR/node-${NODE_VERSION}-linux-x64 /opt/node
echo 'export PATH=$PATH:/opt/node/bin' >/etc/profile.d/node.sh
export PATH=$PATH:/opt/node/bin

# TypeScript
npm install typescript -g

# Pug
npm install pug-cli -g

# Sass
gem install sass

# Go
GO_VERSION=1.8.3
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C $TEMPDIR -xzf -
mv $TEMPDIR/go /opt/go
cat <<-'EOF' >/etc/profile.d/go.sh
	export GOROOT=/opt/go
	export PATH=$PATH:/opt/go/bin
EOF

# Google Cloud SDK
GOOGLE_CLOUD_SDK_VERSION=157.0.0
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" | tar -C $TEMPDIR -xzf -
mv $TEMPDIR/google-cloud-sdk /opt/google_cloud_sdk
echo 'export PATH=$PATH:/opt/google_cloud_sdk/bin' >/etc/profile.d/google_cloud_sdk.sh

# Protocol Buffers
PROTOCOL_BUFFERS_VERSION=3.3.0
curl -o $TEMPDIR/protocol_buffers.zip -fsSL "https://github.com/google/protobuf/releases/download/v${PROTOCOL_BUFFERS_VERSION}/protoc-${PROTOCOL_BUFFERS_VERSION}-linux-x86_64.zip"
mkdir /opt/protocol_buffers
7za x -o/opt/protocol_buffers -tzip $TEMPDIR/protocol_buffers.zip
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
mkdir -p /opt/docker_compose
curl -fsSL -o /opt/docker_compose/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64
chmod a+x /opt/docker_compose/docker-compose
echo 'export PATH=$PATH:/opt/docker_compose' >/etc/profile.d/docker_compose.sh

rm -Rf $TEMPDIR
