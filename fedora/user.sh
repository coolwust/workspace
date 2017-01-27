#!/bin/sh

set -ex

# general
mkdir -p ~/bin

# systemd
mkdir -p ~/.config/systemd/user

# git 
mkdir -p ~/.config/git
cp git/gitignore ~/.config/git/ignore

# vim
cp vim/vimrc ~/.vimrc
git clone "https://github.com/fatih/vim-go.git" ~/.vim/pack/plugins/start/vim-go
git clone "https://github.com/leafgarland/typescript-vim.git" ~/.vim/pack/plugins/start/typescript-vim
git clone "https://github.com/vim-scripts/DrawIt.git" ~/.vim/pack/plugins/start/DrawIt

# tmux
cp tmux/tmux.conf ~/.tmux.conf

# ranger
mkdir -p ~/.config/ranger
cp ranger/rc.conf ~/.config/ranger/rc.conf

# go
mkdir -p ~/Documents/go/src ~/Documents/go/bin
cat <<-'EOF' >>~/.bash_profile
	export GOPATH=$HOME/Documents/go
	export PATH=$PATH:$HOME/Documents/go/bin
EOF

# c
mkdir -p ~/Documents/c

# dropbox
curl -fsSL "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -C ~ -zxf -
curl -o ~/bin/dropbox -fsSL "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod u+x ~/bin/dropbox
cp dropbox/dropbox.service ~/.config/systemd/user
