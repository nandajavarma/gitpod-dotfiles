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

if [ -n "$(ls -A /workspaces 2>/dev/null)" ]; then
    for dir in /workspaces/*/; do
        echo -e "\033[32mcreating cursor rules in ${dir}\033[0m"
        mkdir -p "${dir}.cursor/rules" || echo "could not create cursor rules in ${dir}"
        cp -r ~/dotfiles/.cursor/rules/* "${dir}.cursor/rules/." || echo "could not create cursor rules in ${dir}"
    done
fi

sudo apt update
sudo apt install -y tmux vim

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh || echo "could not clone ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vscode/.oh-my-zsh || echo "could not clone ohmyzsh for remote user"

mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts || echo "could not create known_hosts"
mkdir -p /home/vscode/.ssh
ssh-keyscan github.com >> /home/vscode/.ssh/known_hosts || echo "could not create known_hosts for remote user"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || echo "could not clone Vundle.vim"
git clone https://github.com/VundleVim/Vundle.vim.git /home/vscode/.vim/bundle/Vundle.vim || echo "could not clone Vundle.vim for remote user"

vim +PluginInstall +qall
