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

# screen自動起動
if [ "x$TERM" = "xscreen" ]; then
  chpwd () { echo -n "_`dirs`\\" }
  preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*)
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2)); then
          cmd[1]=$cmd[2]
        fi
        ;&
      *)
        echo -n "k$cmd[1]:t\\"
        return
        ;;
    esac
    local -A jt; jt=(${(kv)jobtexts})
    $cmd >>(read num rest
      cmd=(${(z)${(e):-\$jt$num}})
      echo -n "k$cmd[1]:t\\") 2>/dev/null
  }
  chpwd
  alias ssh=ssh_screen
else
  exec screen -S main -xRR
fi
function chpwd() {
  _reg_pwd_screennum
}

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'

# git completion
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "(%b)"
zstyle ':vcs_info:*' actionformats "(%b|%a)"
precmd() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  psvar[1]=$vcs_info_msg_0_
}
RPROMPT="%1v[%~]"
autoload bashcompinit
bashcompinit
if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
fi

#rbenv
export CONFIGURE_OPTS='--enable-shared'
if [ -f ~/.rbenv/completions/rbenv.zsh ]; then
  source ~/.rbenv/completions/rbenv.zsh
fi
eval "$(rbenv init -)"

#nvm
. ~/.nvm/nvm.sh

