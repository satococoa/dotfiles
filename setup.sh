#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.MacOSX .gemrc .gitconfig .gitignore_global .gvimrc .powconfig .pryrc .tmux.conf .vim .vimrc .zsh .zshrc .railsrc update.sh)
for file in ${files[@]};do
  _path=$DIR/$file
  ln -s $_path ~/$file
done
$(cd ~; mv ~/.gitignore_global ~/.gitignore)
