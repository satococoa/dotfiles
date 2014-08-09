#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
files=(.gemrc .gitconfig .gitignore_global .gvimrc .tmux.conf .vim .vimrc .zsh .zshrc update.sh)
for file in ${files[@]};do
  _path=$DIR/$file
  echo "ln -s $_path ~/$file"
  ln -s $_path ~/$file
done
$(cd ~; mv ~/.gitignore_global ~/.gitignore)

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew tap homebrew/dupes
brew tap homebrew/versions
brew tap motemen/ghq
brew tap peco/peco
brew tap sanemat/font

brews=(ghq git go hub jq peco rbenv ruby-build reattach-to-user-namespace ricty tmux z zsh-completions direnv mercurial)

for brew in ${brews[@]}; do
  echo "brew install $brew ..."
  brew install $brew
done

# cask
brew install caskroom/cask/brew-cask

casks=(alfred android-file-transfer appcleaner atom butter crashlytics dropbox google-chrome hipchat iterm2 licecap testflight vagrant virtualbox)
for cask in ${casks[@]}; do
  echo "brew cask install $cask ..."
  brew cask install $cask
done
brew cask alfred link
