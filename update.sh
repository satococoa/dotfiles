#!/bin/sh
echo '(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)'
(cd ~/dev/src/github.com/satococoa/dotfiles && git pull)
echo 'brew update'
brew update
echo 'brew upgrade'
brew upgrade
echo 'asdf plugin update --all'
asdf plugin update --all
if command -v gcloud > /dev/null; then
  echo 'gcloud components update'
  gcloud components update
fi

