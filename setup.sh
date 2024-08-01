#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(update.sh .zshrc)
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

# .config/ にディレクトリごとシンボリックリンクを貼る
mkdir -p ~/.config
config_dirs=(git alacritty zellij)
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

# .config/ 内に特定ファイルのシンボリックリンクを貼る
mkdir -p ~/.config
config_files=(zed/settings.json zed/keymap.json)
for config_file in ${config_files[@]};do
  _path=$DIR/$config_file
  _target=~/.config/$config_file
  if [[ -f $_target ]]; then
    echo "remove exsisting file: $_target"
    rm $_target
  fi
  echo "ln -s $_path $_target"
  ln -s $_path $_target
done

# homebrew
brews=(ghq git jq peco direnv zsh-completions zellij asdf pure go ripgrep font-udev-gothic)
for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done

casks=(1password appcleaner discord docker figma google-chrome imageoptim raindropio visual-studio-code zed)
for brew in ${casks[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
