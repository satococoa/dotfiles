bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
PROMPT="${USER}@${HOST}%(!.#.$) "
RPROMPT="[%~]"
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
function history-all { history -E 1 }
autoload -U compinit
compinit

case "${OSTYPE}" in
  darwin*)
  alias ls="ls -G -w"
  export LSCOLORS=DxGxcxdxCxegedabagacad
  export EDITOR=/usr/bin/vim
  ;;
  linux*)
  umask 002
  alias ls="ls --color=auto"
  export EDITOR=/usr/local/bin/vim
  export LS_COLORS="di=01;33"
  ;;
esac

source $HOME/.zsh/cdd
source $HOME/.zsh/ssh_screen

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'

# git completion
autoload bashcompinit
bashcompinit
if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
  RPROMPT="$(__git_ps1)[%~]"
fi

#rbenv
export CONFIGURE_OPTS='--enable-shared'
if [ -f ~/.rbenv/completions/rbenv.zsh ]; then
  source ~/.rbenv/completions/rbenv.zsh
fi
eval "$(rbenv init -)"

#nvm
. ~/.nvm/nvm.sh

