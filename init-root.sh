#!/bin/sh

set -ex

apt-get update && apt-get install -y \
	ascii \
	bc \
	curl \
	gcc \
	git \
	git-lfs \
	gzip \
	less \
	man \
	p7zip \
	python3 \
	ranger \
	tar \
	xz-utils \
	tmux \
	vim \
	ruby \
	apt-transport-https \
	ca-certificates \
	gnupg2 \
	software-properties-common

# GO
GO_VERSION="1.11"
curl -fsSL "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C "/opt" -xzf -
cat <<-'EOF' >"/etc/profile.d/go.sh"
	export GOROOT=/opt/go
	export PATH=$PATH:/opt/go/bin
EOF

# Docker
curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce

# Node
NODE_VERSION="v10.11.0"
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C "/opt" -Jxf -
mv "/opt/node-${NODE_VERSION}-linux-x64" "/opt/node"
cat <<-'EOF' >"/etc/profile.d/node.sh"
	export PATH=$PATH:/opt/node/bin
EOF
