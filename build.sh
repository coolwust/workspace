#!/bin/sh

[ "$#" -eq 1 ] || (echo "usage: ./build.sh <username>" 1>&2 && exit 1)

set -ex

dnf -y update && dnf -y install \
  curl \
  tar \
  less \
  man \
  procps-ng \
  vim \
  tmux \
  ranger \
  git \
  gcc \
  docker \
  passwd

GO_VERSION=1.7.4
NODE_VERSION=v7.3.0
GCLOUD_VERSION=139.0.0
PATH=$PATH:/opt/node/bin
curl -fsSL "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -xzf -
mv .dropbox-dist /opt/dropbox
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -Jxf -
mv node-${NODE_VERSION}-linux-x64 /opt/node
npm install -g typescript
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -

USER_DIR=/home/"$1"
useradd -m "$1"
cp vim/vimrc $USER_DIR/.vimrc
cp tmux/tmux.conf $USER_DIR/.tmux.conf
cp bash/bash_profile $USER_DIR/.bash_profile
mkdir -p $USER_DIR/.config/ranger
cp ranger/rc.conf $USER_DIR/.config/ranger/rc.conf
mkdir -p $USER_DIR/.config/systemd/user
cp dropbox/dropbox.service $USER_DIR/.config/systemd/user
git clone "https://github.com/fatih/vim-go.git" $USER_DIR/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" $USER_DIR/.vim/pack/plugins/start/typescript-vim
mkdir -p $USER_DIR/Documents/go/src $USER_DIR/Documents/c
chown -R "$1":"$1" $USER_DIR
