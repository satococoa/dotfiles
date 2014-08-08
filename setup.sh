#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .gvimrc .tmux.conf .vim .vimrc .zsh .zshrc update.sh)
for file in ${files[@]};do
  _path=$DIR/$file
  ln -s $_path ~/$file
done
$(cd ~; mv ~/.gitignore_global ~/.gitignore)
