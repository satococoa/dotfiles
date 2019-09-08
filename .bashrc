# alieases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias d='docker-compose'

# completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# peco
peco-select-history() {
  local action
  action="$(history | peco | cut -c 8-)"
  history -s "$action"
  READLINE_LINE="${action}"
  READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": peco-select-history'

peco-select-project() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    READLINE_LINE="cd ${selected_file}"
    READLINE_POINT=${#READLINE_LINE}
  fi
}
bind -x '"\C-]": peco-select-project'

# direnv
eval "$(direnv hook bash)"

ulimit -n 1024

