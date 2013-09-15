#!/bin/sh
echo '(cd ~/dotfiles && git pull)'
(cd ~/dotfiles && git pull)
echo 'brew update'
brew update
echo 'brew upgrade'
brew upgrade
echo 'gem update'
gem update
echo 'sudo motion update'
sudo motion update
