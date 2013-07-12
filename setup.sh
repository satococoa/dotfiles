#!/bin/zsh

files=(.MacOSX .gemrc .gitconfig .gitignore_global .gvimrc .powconfig .pryrc .tmux.conf .vim .vimrc .zsh .zshrc .railsrc update.sh)
for file in $files;do
  _path=`basename \`pwd\``/$file
  ln -s $_path ~/$file
done
cd
mv ~/.gitignore_global ~/.gitignore
