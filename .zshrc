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
  alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
  alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
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

# tmux自動起動
if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
  if ( tmux has-session ); then
    session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]*\).*$/\1/'`
    if [ -n "$session" ]; then
      echo "Attache tmux session $session."
      tmux attach-session -t $session
    else
      echo "Session has been already attached."
      tmux list-sessions
    fi
  else
    echo "Create new tmux session."
    tmux
  fi
fi
source $HOME/.zsh/cdd
function chpwd() {
  _cdd_chpwd
}

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'

# z
. `brew --prefix`/etc/profile.d/z.sh

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

# rbenv
export CONFIGURE_OPTS='--with-readline-dir=/usr/local/Cellar/readline/6.2.2'
eval "$(rbenv init -)"

# rubymotion
export RUBYMOTION_LIB='~/dev/motion/RubyMotion/lib'

# PATH
export PATH="/usr/local/share/npm/bin:/usr/local/share/python:${PATH}"
