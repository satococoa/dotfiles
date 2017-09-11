# alieases
alias r='rails'
alias g='git'
alias be='bundle exec'

# completions
if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
  PS1="\h:\W\$(__git_ps1) \u\$ "
fi

if [ -f ~/.anyenv/envs/rbenv/completions/rbenv.bash ]; then
  source ~/.anyenv/envs/rbenv/completions/rbenv.bash
fi

if [ -f /usr/local/bin/aws_completer ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

# *env
eval "$(anyenv init -)"

# direnv
eval "$(direnv hook bash)"

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
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'

peco-select-project() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
    fi
  fi
}
bind -x '"\C-]": peco-select-project'
