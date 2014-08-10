#!/bin/sh
echo '(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)'
(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)
echo 'brew update'
brew update
echo 'brew upgrade'
brew upgrade
echo 'brew cleanup'
brew cleanup
echo 'brew cask cleanup'
brew cask cleanup
echo 'gem update'
gem update
echo 'gem cleanup'
gem cleanup
echo 'sudo motion update'
sudo motion update
