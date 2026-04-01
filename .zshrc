# Homebrew
if [[ $(uname -m) == "arm64" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
else
  BREW_BIN="/usr/local/bin/brew"
fi
if command -v "$BREW_BIN" >/dev/null 2>&1; then
  eval "$("$BREW_BIN" shellenv)"
fi

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

# codex
if command -v codex &>/dev/null; then
  eval "$(codex completion zsh)"
fi

# wtp
if command -v wtp &>/dev/null; then
  eval "$(wtp shell-init zsh)"
fi

# direnv
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# git branch cleanup helpers
git-list-prunable-local() {
  git fetch origin &&
    comm -23 \
      <(git for-each-ref --format='%(refname:short)' refs/heads --merged origin/main | grep -F -x -v -e main -e master | sort) \
      <(git worktree list --porcelain | sed -n 's/^branch refs\/heads\///p' | sort)
}

git-prune-merged-local() {
  git-list-prunable-local | xargs -r git branch -d
}
