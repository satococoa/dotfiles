#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.tmux.conf update.sh .zshrc)
for file in ${files[@]};do
  _path=$DIR/$file
  _target=~/$file
  if [[ -f $_target ]]; then
    echo "remove exsisting file: $_target"
    rm $_target
  fi
  echo "ln -s $_path $_target"
  ln -s $_path $_target
done

# .config
mkdir -p ~/.config
config_dirs=(git)
for config_dir in ${config_dirs[@]};do
  _path=$DIR/$config_dir
  _target=~/.config/$config_dir
  if [[ -d $_target ]]; then
    echo "remove exsisting dir: $_target"
    rm -rf $_target
  fi
  echo "ln -s $_path $_target"
  ln -s $_path $_target
done

# homebrew
brews=(ghq git jq peco direnv zsh-completions tmux asdf pure)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
