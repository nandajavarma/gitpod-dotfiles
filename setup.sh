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

sudo apt install -y tmux vim

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh || echo "could not clone ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vscode/.oh-my-zsh || echo "could not clone ohmyzsh for remote user"

mkdir -p ~/.ssh || echo "could not create ssh directory"
ssh-keyscan github.com >> ~/.ssh/known_hosts || echo "could not create known_hosts"
mkdir -p /home/vscode/.ssh || echo "could not create ssh directory for remote user"
ssh-keyscan github.com >> /home/vscode/.ssh/known_hosts || echo "could not create known_hosts for remote user"


if ! command -v npm &> /dev/null; then
    echo "Skipping claude code install, npm not found"
    return 0
fi

if command -v claude &> /dev/null; then
    echo "Claude Code is already installed"
    return 0
fi

echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code
claude config set -g theme dark

echo "Copying Claude config from root..."
sudo cp /root/.claude.json ~/.claude.json || {
    echo "No Claude config found in root, skipping copy"
    return 0
}

sudo chown "$(id -u):$(id -g)" ~/.claude.json