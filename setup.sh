#!/usr/bin/env bash
set -Eeuo pipefail

git config --global push.autoSetupRemote true

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim ~/.oh-my-zsh ~/.emacs.d

ln -s ~/.dotfiles/.vimrc ~/ || true
ln -s ~/.dotfiles/.tmux.conf ~/ || true

sudo apt update
sudo apt install -y tmux vim

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

ln -s ~/.dotfiles/.zshrc ~/ || true

echo 'alias k="kubectl"' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc

# hack to be able to clone private repo https://github.com/gitpod-io/gitpod/issues/1191#issuecomment-855484471
git config --global url."https://".insteadOf git://
git config --global url."https://github.com/".insteadOf ssh://git@github.com/
git config --global url."https://github.com/".insteadOf git@github.com:

git clone git@github.com:nandajavarma/notes.git  $HOME/.deft
cd --
