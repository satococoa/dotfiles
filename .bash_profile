export CC=/usr/bin/gcc-4.2
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
  PS1="\h:\W\$(__git_ps1) \$ "
fi

alias r='rails'
