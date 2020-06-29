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
PROMPT="%(?!%F{yellow}☀%f !%F{cyan}☂ %f) $ "
RPROMPT="[%~]"
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
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit -u
fi
typeset -U path PATH

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
. $(brew --prefix asdf)/asdf.sh
# go
export GOPATH="$HOME/dev"
export PATH=$PATH:$GOPATH/bin
# flutter
export PATH=$HOME/dev/flutter/bin:$PATH
# mysql-client
export PATH=/usr/local/opt/mysql-client/bin:$PATH
export PATH=/usr/local/opt/libpq/bin:$PATH

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias d='docker-compose'
alias c='code-insiders'

# git completion
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "(%b)"
zstyle ':vcs_info:*' actionformats "(%b|%a)"
function _GIT_precmd {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  psvar[1]=$vcs_info_msg_0_
}
precmd_functions=($precmd_functions _GIT_precmd)
RPROMPT="%1v[%~]"
autoload bashcompinit
bashcompinit
ulimit -n 1024

# google cloud SDK
if [ -e "$HOME/dev/google-cloud-sdk" ]; then
  source "$HOME/dev/google-cloud-sdk/path.zsh.inc"
  source "$HOME/dev/google-cloud-sdk/completion.zsh.inc"
fi

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

# direnv
eval "$(direnv hook $0)"
