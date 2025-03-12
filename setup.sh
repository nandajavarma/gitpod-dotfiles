#!/usr/bin/env bash
set -Eeuo pipefail

git config --global push.autoSetupRemote true

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim ~/.oh-my-zsh ~/.emacs.d

ln -s ~/.dotfiles/.vimrc ~/ || echo "could not create vimrc"
ln -s ~/.dotfiles/.tmux.conf ~/ || echo "could not create tmux.conf"

sudo apt update
sudo apt install -y tmux vim

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

ln -s ~/.dotfiles/.zshrc ~/ || echo "could not create zshrc"
