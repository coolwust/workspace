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
	python3 \
	ranger \
	tar \
	tmux \
	vim \
	xz \
	ruby

TEMPDIR=$(mktemp -d)

# MariaDB

dnf install mariadb mariadb-server
systemctl enable mariadb
# start server and log in as root `mysql -u root -p`, set password
# SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new_password');

# The following has libncurses.so.5 issue
# MARIADB_VERSION=10.2.6
# dnf -y install libaio
# curl -fsSL https://downloads.mariadb.org/f/mariadb-${MARIADB_VERSION}/bintar-linux-glibc_214-x86_64/mariadb-${MARIADB_VERSION}-linux-glibc_214-x86_64.tar.gz | tar -C $TEMPDIR -zxf -
# mv $TEMPDIR/mariadb-${MARIADB_VERSION}-linux-glibc_214-x86_64 /opt/mysql
# cd /opt/mysql
# groupadd mysql 
# useradd -g mysql mysql
# chown -R mysql:mysql .
# scripts/mysql_install_db --user=mysql --basedir=/opt/mysql --datadir=/opt/mysql/data
# chown -R root .
# chown -R mysql data
# echo 'export PATH=$PATH:/opt/mysql/bin' >/etc/profile.d/mysql.sh
# mysqld_safe --datadir='/opt/mysql/data'

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
PROTOCOL_BUFFERS_VERSION=3.6.0
curl -o $TEMPDIR/protoc.zip -fsSL "https://github.com/google/protobuf/releases/download/v${PROTOCOL_BUFFERS_VERSION}/protoc-${PROTOCOL_BUFFERS_VERSION}-linux-x86_64.zip"
mkdir /opt/protoc
7za x -o/opt/protoc -tzip $TEMPDIR/protoc.zip
echo 'export PATH=$PATH:/opt/protoc/bin' >/etc/profile.d/protoc.sh

rm -Rf $TEMPDIR
find /opt -type f -exec chmod 664 {} \+
find /opt -type d -exec chmod 775 {} \+
chmod a+x /opt/go/bin/* /opt/protoc/bin/*
