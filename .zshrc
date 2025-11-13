# zsh settings
bindkey -e
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
  fpath=("$HOMEBREW_PREFIX/share/zsh-completions" "$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
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

# fzf
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

function fzf-select-project () {
  if ! command -v ghq &>/dev/null || ! command -v fzf &>/dev/null; then
    zle reset-prompt
    return
  fi

  local selected_dir
  selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER" 2>/dev/null)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-select-project
bindkey '^]' fzf-select-project

# wtp
if command -v wtp &>/dev/null; then
  eval "$(wtp shell-init zsh)"
fi
