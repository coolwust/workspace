#!/bin/sh

[ "$#" -eq 1 ] || (echo "usage: ./build.sh <username>" 1>&2 && exit 1)

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
  python \
  fuse \
  acd_cli

NODE_VERSION=v7.3.0
PATH=$PATH:/opt/node/bin
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -Jxf -
mv node-${NODE_VERSION}-linux-x64 /opt/node
npm install -g typescript

GO_VERSION=1.7.4
curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf -

GCLOUD_VERSION=139.0.0
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz" | tar -C /opt -xzf -

USER_DIR=/home/"$1"
useradd -m "$1"

mkdir -p $USER_DIR/.config/systemd/user

mkdir -p $USER_DIR/.cache/vim/backup $USER_DIR/.cache/vim/swap $USER_DIR/.cache/vim/undo
cp vim/vimrc $USER_DIR/.vimrc
git clone "https://github.com/fatih/vim-go.git" $USER_DIR/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" $USER_DIR/.vim/pack/plugins/start/typescript-vim
git clone "https://github.com/vim-scripts/DrawIt.git" $USER_DIR/.vim/pack/plugins/start/DrawIt

cp tmux/tmux.conf $USER_DIR/.tmux.conf

cp bash/bash_profile $USER_DIR/.bash_profile

mkdir -p $USER_DIR/.config/ranger
cp ranger/rc.conf $USER_DIR/.config/ranger/rc.conf

mkdir -p $USER_DIR/go/src

mkdir $USER_DIR/c

mkdir $USER_DIR/acd
cp acd_cli/acd_cli.service $USER_DIR/.config/systemd/user

chown -R "$1":"$1" $USER_DIR
