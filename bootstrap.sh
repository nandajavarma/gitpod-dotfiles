#!/usr/bin/env bash
set -Eeuo pipefail

git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim/bundle/Vundle.vim ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

ln -s ~/.dotfiles/.emacs.d ~/.emacs.d
ln -s ~/.dotfiles/.doom.d ~/.doom.d
cd .doom.d/modules/private/spacemacs
git submodule update --init
cd --
~/.emacs.d/bin/doom sync

echo 'alias k="kubectl"' >> ~/.zshrc
