# alieases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias d='docker-compose'

# completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
if [ -f ~/.anyenv/envs/rbenv/completions/rbenv.bash ]; then
  source ~/.anyenv/envs/rbenv/completions/rbenv.bash
fi

# tmux 自動起動
if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
  if ( tmux has-session ); then
    session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]*\).*$/\1/'`
    if [ -n "$session" ]; then
      echo "Attach tmux session $session."
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

# peco
peco-select-history() {
  local action
  action="$(history | peco | cut -c 8-)"
  history -s "${action}"
  eval "${action}"
}
bind '"\C-r": "\erpeco-select-history\n"'

peco-select-project() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
    fi
  fi
}
bind '"\C-]": "\erpeco-select-project\n"'

# *env
eval "$(anyenv init -)"

# direnv
eval "$(direnv hook bash)"
