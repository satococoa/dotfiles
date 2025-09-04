# zsh settings
bindkey -e
# bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt extended_history
setopt share_history
# setopt correct

if [ -n "$HOMEBREW_PREFIX" ]; then
  FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$FPATH
fi
autoload -Uz compinit
compinit
typeset -U path PATH
autoload -U promptinit; promptinit

# Load pure prompt if not in VSCode
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  prompt pure
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}completing %B%d%b%f'

export EDITOR=/usr/bin/vi

# mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# aliases
alias g='git'
alias c='code'

# peco
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER" 2>/dev/null)
  if [ $? -eq 0 ]; then
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-select-project () {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER" 2>/dev/null)
  if [ $? -eq 0 -a -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-select-project
bindkey '^]' peco-select-project
