# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

# tmux自動起動
if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && ( ! expr $TERM_PROGRAM : "^vscode" > /dev/null) && which tmux > /dev/null; then
  if ( tmux has-session ); then
    session=`tmux list-sessions | grep -e '^[0-9].*$' | head -n 1 | sed -e 's/^\([0-9]*\).*$/\1/'`
    if [ -n "$session" ]; then
      echo "Attache tmux session $session."
      exec tmux attach-session -t $session
    else
      echo "Session has been already attached."
      exec tmux list-sessions
    fi
  else
    echo "Create new tmux session."
    exec tmux
  fi
fi

# zsh settings
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt extended_history
setopt share_history
#setopt correct
function history-all { history -E 1 }
if [ -n "$HOMEBREW_PREFIX" ]; then
  FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit -u
fi
autoload bashcompinit
bashcompinit
typeset -U path PATH
autoload -U promptinit; promptinit
prompt pure

# env
export CLICOLOR=1
case "${OSTYPE}" in
  darwin*)
  alias ls="ls -G -w"
  export LSCOLORS=DxGxcxdxCxegedabagacad
  export EDITOR=/usr/bin/vim
  ;;
  linux*)
  umask 002
  alias ls="ls --color=auto"
  export LS_COLORS="di=01;33"
  export EDITOR=/usr/local/bin/vim
  ;;
esac
# ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"
# node
export VOLTA_HOME=$HOME/.volta
export PATH=$VOLTA_HOME/bin:$PATH
# flutter
export PATH=$HOME/dev/flutter/bin:$PATH
# mysql-client
export PATH=$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH
# libpq
export PATH=$HOMEBREW_PREFIX/opt/libpq/bin:$PATH
# dart
export PATH=$PATH:$HOME/.pub-cache/bin
# go
export PATH=$HOME/go/bin:$PATH
# openjdk
export PATH=$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH

# google cloud SDK
if [ -e "$HOME/dev/google-cloud-sdk" ]; then
  source "$HOME/dev/google-cloud-sdk/path.zsh.inc"
  source "$HOME/dev/google-cloud-sdk/completion.zsh.inc"
fi

# direnv
eval "$(direnv hook $0)"

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias d='docker compose'
alias c='code'

# peco
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-select-project () {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-select-project
bindkey '^]' peco-select-project

# Fig post block. Keep at the bottom of this file.
eval "$(fig init zsh post)"

