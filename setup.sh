#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc .update.sh .bash_profile .bashrc .zshrc)
for file in ${files[@]};do
  _path=$DIR/$file
  echo "ln -s $_path ~/$file"
  ln -s $_path ~/$file
done

$(cd ~; mv ~/.gitignore_global ~/.gitignore)

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brews=(ghq git jq peco direnv mercurial zsh-completions reattach-to-user-namespace git-lfs asdf tmux)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
