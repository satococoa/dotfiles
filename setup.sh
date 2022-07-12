#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.tmux.conf update.sh .zshrc)
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
brews=(ghq git jq peco direnv zsh-completions tmux asdf)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
