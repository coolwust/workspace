#!/bin/sh

set -ex

SCRIPT_DIR="$(cd "$( dirname "$0" )" && pwd)"

xdg-user-dirs-update
mkdir -p ~/bin
mkdir -p ~/.config/systemd/user

# Git
mkdir -p ~/.config/git
cp $SCRIPT_DIR/git/gitignore ~/.config/git/ignore

# Vim
cp $SCRIPT_DIR/vim/vimrc ~/.vimrc
git clone "https://github.com/fatih/vim-go.git" ~/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" ~/.vim/pack/plugins/start/typescript-vim
git clone "https://github.com/vim-scripts/DrawIt.git" ~/.vim/pack/plugins/start/DrawIt

# Tmux
cp $SCRIPT_DIR/tmux/tmux.conf ~/.tmux.conf

# Ranger
mkdir -p ~/.config/ranger
cp $SCRIPT_DIR/ranger/rc.conf ~/.config/ranger/rc.conf

# Go
mkdir -p ~/Documents/go
cat <<-'EOF' >>~/.bash_profile
	export GOPATH=$HOME/Documents/go
	export PATH=$PATH:$GOPATH/bin
EOF
export GOPATH=$HOME/Documents/go

# C
mkdir -p ~/Documents/c

# Dropbox
curl -fsSL "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -C ~ -zxf -
curl -o ~/bin/dropbox -fsSL "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod u+x ~/bin/dropbox
cp $SCRIPT_DIR/dropbox/dropbox.service ~/.config/systemd/user

# Go support for Protocol Buffers
# This software has two parts: the protoc-gen-go is a 'protocol compiler plugin'
# that generates Go source files that, once compiled, can access and manage
# protocol buffers; and the proto package is a library that implements run-time
# support for encoding (marshaling), decoding (unmarshaling), and accessing
# protocol buffers.
go get -u github.com/golang/protobuf/{protoc-gen-go,proto}

# gRPC
go get google.golang.org/grpc
