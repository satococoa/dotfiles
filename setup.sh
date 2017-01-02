#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .gvimrc .tmux.conf .vim .vimrc .zsh .zshrc update.sh)
for file in ${files[@]};do
  _path=$DIR/$file
  echo "ln -s $_path ~/$file"
  ln -s $_path ~/$file
done
_fish_path=$DIR/fish
echo "ln -s $_fish_path ~/.config/"
ln -s $_fish_path ~/.config/

$(cd ~; mv ~/.gitignore_global ~/.gitignore)

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brews=(ghq git go hub jq peco readline openssl rbenv ruby-build reattach-to-user-namespace tmux direnv mercurial)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done
