#!/usr/bin/env bash
set -Eeuo pipefail

git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/.zshrc ~/.zshrc || true
ln -s ~/.dotfiles/.vimrc ~/.vimrc || true
ln -s ~/.dotfiles/.vim/bundle/Vundle.vim ~/.vim/bundle/Vundle.vim || true

vim +PluginInstall +qall

ln -s ~/.dotfiles/.doom.d ~/.doom.d || true
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

cd .doom.d/modules/private
rm -rf spacemacs
git clone https://github.com/chenyanming/spacemacs_module_for_doom spacemacs/ spacemacs
cd --
~/.emacs.d/bin/doom sync

echo 'alias k="kubectl"' >> ~/.zshrc
