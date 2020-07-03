#!/bin/bash

DIR=$(dirname $0)
echo "Linking files from $DIR to home directory"
cd ~

for f in .bash_profile .bash_logout .bashrc .gitconfig .tmux.conf .vimrc; do
  ln -s $DIR/$f $f
done
