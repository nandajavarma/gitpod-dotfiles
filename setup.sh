#!/usr/bin/env bash
set -Eeuo pipefail

git config --global push.autoSetupRemote true

rm -rf ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/bundle/Vundle.vim ~/.oh-my-zsh ~/.emacs.d

cp -r ~/dotfiles/.vim /home/vscode/ || echo "could not create vim for remote user"
cp -r ~/dotfiles/.vim ~/ || echo "could not create vim for root user"

cp -r ~/dotfiles/.vimrc /home/vscode/ || echo "could not create vimrc for remote user"
cp -r ~/dotfiles/.vimrc ~/ || echo "could not create vimrc for root user"

cp -r ~/dotfiles/.tmux.conf /home/vscode/ || echo "could not create tmux.conf for remote user"
cp -r ~/dotfiles/.tmux.conf ~/ || echo "could not create tmux.conf for root user"

cp -r ~/dotfiles/.zshrc /home/vscode/ || echo "could not create zshrc for remote user"
cp -r ~/dotfiles/.zshrc ~/ || echo "could not create zshrc for root user"

for dir in /workspace/*/; do
    mkdir -p "${dir}.cursor/rules"
    cp -r ~/dotfiles/.cursor/rules/* "${dir}.cursor/rules/." || echo "could not create cursor rules in ${dir}"
done

sudo apt update
sudo apt install -y tmux vim

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vscode/.oh-my-zsh

mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts || echo "could not create known_hosts"
mkdir -p /home/vscode/.ssh
ssh-keyscan github.com >> /home/vscode/.ssh/known_hosts || echo "could not create known_hosts for remote user"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git /home/vscode/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
vim +PluginInstall +qall
