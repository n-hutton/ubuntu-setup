#!/bin/bash

cp ~/.gitconfig ./config_files
cp ~/.vimrc ./config_files
cp ~/.bashrc ./config_files
cp ~/.zshrc ./config_files
cp ~/gnome-terminal-profiles.dconf ./config_files
cp -rf ~/repos/scripts ./
cp -rf ~/.vim ./config_files
rm -rf ./config_files/.vim/undo/*
cp -rf ~/.git/hooks/ ./config_files
