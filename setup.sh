#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc .update.sh .bash_profile .bashrc)
for file in ${files[@]};do
  _path=$DIR/$file
  echo "ln -s $_path ~/$file"
  ln -s $_path ~/$file
done

$(cd ~; mv ~/.gitignore_global ~/.gitignore)

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brews=(ghq git go hub jq peco readline openssl reattach-to-user-namespace tmux direnv mercurial bash-completion bash)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
