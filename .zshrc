export LANG=ja_JP.UTF-8
case "${OSTYPE}" in
  darwin*)
  if [ x$TERM != xscreen ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
  else
    alias ls="ls -G -w"
  fi
  ;;
  linux*)
  if [ x$TERM != xscreen ]; then
    export PATH=$PATH:$HOME/flex_sdk_3/bin
    export EDITOR=/usr/bin/vim
    umask 002
  else
    alias ls="ls --color=auto"
  fi
  ;;
esac
bindkey -e
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
if [ "$TERM" = "screen" ]; then
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
fi
function ssh_screen(){
 eval server=\${$#}
 screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
  alias ssh=ssh_screen
else
  exec `/usr/bin/env screen` -S main -xRR
fi
