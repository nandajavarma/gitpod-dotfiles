#!/usr/bin/env bash
set -Eeuo pipefail

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim ~/.oh-my-zsh ~/.emacs.d

ln -s ~/.dotfiles/.vimrc ~/ || true
ln -s ~/.dotfiles/.tmux.conf ~/ || true

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

ln -s ~/.dotfiles/.zshrc ~/ || true

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

ln -s ~/.dotfiles/.doom.d ~/ || true
ln -s ~/.dotfiles/.emacs.d ~/ || true

mkdir -p .doom.d/modules/private
cd .doom.d/modules/private
rm -rf spacemacs
git clone https://github.com/chenyanming/spacemacs_module_for_doom spacemacs/

~/.emacs.d/bin/doom sync &

git clone git@github.com:nandajavarma/notes.git  $HOME/.deft
cd --

echo 'alias k="kubectl"' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
