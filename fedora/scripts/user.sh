#!/bin/sh

set -ex

# systemd
mkdir -p ~/.config/systemd/user

# vim
mkdir -p ~/.cache/vim/backup ~/.cache/vim/swap ~/.cache/vim/undo
cp ../data/vim/vimrc ~/.vimrc
git clone "https://github.com/fatih/vim-go.git" ~/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" ~/.vim/pack/plugins/start/typescript-vim
git clone "https://github.com/vim-scripts/DrawIt.git" ~/.vim/pack/plugins/start/DrawIt

# tmux
cp ../data/tmux/tmux.conf ~/.tmux.conf

# ranger
mkdir -p ~/.config/ranger
cp ../data/ranger/rc.conf ~/.config/ranger/rc.conf

# go
mkdir -p ~/go/src ~/go/bin
cat <<-'EOF' >>~/.bash_profile
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/bin
EOF

# c
mkdir ~/c

# acd_cli
mkdir ~/acd
cp ../data/acd_cli/amazon-cloud-drive.service ~/.config/systemd/user
