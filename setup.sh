#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.MacOSX .gemrc .gitconfig .gitignore_global .gvimrc .powconfig .pryrc .tmux.conf .vim .vimrc .zsh .zshrc .railsrc update.sh)
for file in ${files[@]};do
  _path=$DIR/$file
  ln -s $_path ~/$file
done
if ! [ -d ~/.rbenv ]; then
  mkdir ~/.rbenv
fi
ln -s $DIR/.rbenv/default-gems ~/.rbenv/default-gems
$(cd ~; mv ~/.gitignore_global ~/.gitignore)
