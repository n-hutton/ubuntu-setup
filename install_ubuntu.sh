#!/bin/bash

cp ./config_files/.gitconfig ~/
cp ./config_files/.vimrc ~/
cp ./config_files/.bashrc ~/
cp ./config_files/.zshrc ~/
cp ./config_files/gnome-terminal-profiles.dconf ~/

mkdir -p ~/repos/
mkdir -p ~/.git

cp -rf ./scripts ~/repos/
cp -rf ./config_files/.vim ~/
cp -rf ./config_files/hooks/ ~/.git/
