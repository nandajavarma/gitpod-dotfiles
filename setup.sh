#!/usr/bin/env bash
set -Eeuo pipefail

git config --global push.autoSetupRemote true

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim ~/.oh-my-zsh ~/.emacs.d

sudo apt update
sudo apt install -y tmux vim

ln -s ~/.dotfiles/.vimrc ~/ || true
ln -s ~/.dotfiles/.tmux.conf ~/ || true

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

ln -s ~/.dotfiles/.zshrc ~/ || true

git config --global push.autoSetupRemote true

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo 'alias k="kubectl"' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
