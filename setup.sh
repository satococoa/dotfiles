#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc update.sh .bash_profile .bashrc .zshrc)
for file in ${files[@]};do
  _path=$DIR/$file
  echo "ln -s $_path ~/$file"
  ln -s $_path ~/$file
done

# .config
mkdir -p ~/.config
config_dirs=(git)
for config_dir in ${config_dirs[@]};do
  _path=$DIR/$config_dir
  echo "ln -s $_path ~/.config/$config_dir"
  ln -s $_path ~/.config/$config_dir
done

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brews=(ghq git jq peco direnv mercurial zsh-completions reattach-to-user-namespace git-lfs asdf tmux)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
