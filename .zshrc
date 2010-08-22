case "${OSTYPE}" in
  darwin*)
  alias ls="ls -G -w"
  export LSCOLORS=DxGxcxdxCxegedabagacad
  ;;
  linux*)
  umask 002
  alias ls="ls --color=auto"
  export EDITOR=/usr/bin/vim
  export LS_COLORS="di=01;33"
  ;;
esac
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export MANPATH=/usr/local/share/man:/usr/share/man:/usr/X11/share/man
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
source $HOME/.zsh/cdd
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
function ssh_screen(){
  eval server=\${$#}
  screen -t $server ssh "$@"
}
function chpwd() {
  _reg_pwd_screennum
}
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
