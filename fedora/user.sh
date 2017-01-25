#!/bin/sh

printf "oauth_data file download link (see https://tensile-runway-92512.appspot.com):\n"
read OAUTH_DATA_LINK

set -ex

# systemd
mkdir -p ~/.config/systemd/user

# vim
mkdir -p ~/.cache/vim/backup ~/.cache/vim/swap ~/.cache/vim/undo
cp vim/vimrc ~/.vimrc
git clone "https://github.com/fatih/vim-go.git" ~/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" ~/.vim/pack/plugins/start/typescript-vim
git clone "https://github.com/vim-scripts/DrawIt.git" ~/.vim/pack/plugins/start/DrawIt

# tmux
cp tmux/tmux.conf ~/.tmux.conf

# bash
cp bash/bash_profile ~/.bash_profile

# ranger
mkdir -p ~/.config/ranger
cp ranger/rc.conf ~/.config/ranger/rc.conf

# go
mkdir -p ~/go/src ~/go/bin

# c
mkdir ~/c

# acd_cli
mkdir -p ~/.cache/acd_cli ~/.config/acd_cli ~/acd
cp acd_cli/amazon-cloud-drive.service ~/.config/systemd/user
curl -o ~/.cache/acd_cli/oauth_data -fsSL $OAUTH_DATA_LINK
systemctl --user enable amazon-cloud-drive
systemctl --user start amazon-cloud-drive
