#!/bin/sh

set -ex

SCRIPT_DIR="$(cd "$( dirname "$0" )" && pwd)"

# Git
mkdir -p "$HOME/.config/git"
cp "$SCRIPT_DIR/git/gitignore" "$HOME/.config/git/ignore"

# Vim
cp "$SCRIPT_DIR/vim/vimrc" "$HOME/.vimrc"
git clone "https://github.com/fatih/vim-go.git" "$HOME/.vim/pack/plugins/start/vim-go"
git clone "https://github.com/vim-scripts/DrawIt.git" "$HOME/.vim/pack/plugins/start/DrawIt"

# tmux
cp "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Ranger
mkdir -p "$HOME/.config/ranger"
cp "$SCRIPT_DIR/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

# Go
mkdir "$HOME/go"
cat <<-'EOF' >>"$HOME/.bash_profile"
	export GOPATH=$HOME/go
	export PATH=$PATH:$GOPATH/bin
EOF

# C
mkdir -p "$HOME/c"
