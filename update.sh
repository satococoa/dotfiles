#!/bin/sh
echo '(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)'
(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)
echo 'brew update'
brew update
echo 'brew upgrade --all'
brew upgrade --all
echo 'brew cleanup'
brew cleanup
echo 'gem update'
gem update
# echo 'gem cleanup'
# gem cleanup
