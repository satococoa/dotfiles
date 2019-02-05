#!/bin/sh
echo '(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)'
(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)
echo 'brew update'
brew update
echo 'brew upgrade'
brew upgrade

