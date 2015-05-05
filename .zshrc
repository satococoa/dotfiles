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
# setopt correct
function history-all { history -E 1 }
fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit
typeset -U path PATH

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
. /usr/local/etc/profile.d/z.sh

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
export CONFIGURE_OPTS='--disable-install-rdoc'
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl) --with-readline-dir=$(brew --prefix readline)"
export RUBY_MAKE_OPTS='-j 2'
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

# bundler
export BUNDLE_JOBS=4

# rubymotion
export RUBYMOTION_LIB="$HOME/dev/github/RubyMotion/lib"

# golang
export GOPATH="$HOME/dev"
export PATH=$PATH:$GOPATH/bin

# aws
if which aws > /dev/null; then source /usr/local/share/zsh/site-functions/_aws; fi

# PATH
export PATH=/usr/local/bin:$PATH
export ATOM_PATH=~/Applications
export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk
alias android-studio="open -a Android\ Studio"

# mono
export MONO_GAC_PREFIX="/usr/local"

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

function prake () {
  local task=$(bin/rake -W -T | peco | cut -d " " -f 2)
  if [ -n "$task" ]; then
    echo "bin/rake ${task}"
    bin/rake ${task}
  fi
}

function peco-src () {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
eval "$(direnv hook $0)"
