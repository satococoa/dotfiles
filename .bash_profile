export EDITOR=/usr/bin/vim
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth

# alieases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias titanium="$HOME/Library/Application\ Support/Titanium/mobilesdk/osx/1.7.2/titanium.py"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
  PS1="\h:\W\$(__git_ps1) \u\$ "
fi

export CONFIGURE_OPTS='--enable-shared'
if [ -f ~/.rbenv/completions/rbenv.bash ]; then
  source ~/.rbenv/completions/rbenv.bash
fi

eval "$(rbenv init -)"
. ~/.nvm/nvm.sh

