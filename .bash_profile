export CC=/usr/bin/gcc-4.2
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

alias r='rails'
