# zsh settings
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt extended_history
setopt share_history
#setopt correct
function history-all { history -E 1 }
if [ -n "$HOMEBREW_PREFIX" ]; then
  FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
  # Improve completion performance with caching
  autoload -Uz compinit
  if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
  else
    compinit -C -i
  fi
fi
autoload bashcompinit
bashcompinit
typeset -U path PATH
autoload -U promptinit; promptinit
prompt pure

# Plugins (requires brew install)
if [ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Enhanced completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}completing %B%d%b%f'

# env
export CLICOLOR=1
case "${OSTYPE}" in
  darwin*)
  alias ls="ls -G -w"
  export LSCOLORS=DxGxcxdxCxegedabagacad
  export EDITOR=/usr/bin/vim
  ;;
  linux*)
  alias ls="ls --color=auto"
  export LS_COLORS="di=01;33"
  export EDITOR=/usr/local/bin/vim
  ;;
esac

# go
export PATH=$HOME/go/bin:$PATH
# openjdk
export PATH=$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
# mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
# bun
export PATH="$HOME/.bun/bin:$PATH"
# flutter
export PATH=$HOME/dev/flutter/bin:$PATH
# dart
export PATH=$PATH:$HOME/.pub-cache/bin
# mysql-client
export PATH=$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH
# libpq
export PATH=$HOMEBREW_PREFIX/opt/libpq/bin:$PATH

# google cloud SDK
if [ -e "$HOME/dev/google-cloud-sdk" ]; then
  source "$HOME/dev/google-cloud-sdk/path.zsh.inc"
  source "$HOME/dev/google-cloud-sdk/completion.zsh.inc"
fi

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'
alias d='docker compose'
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

# Added by Windsurf
export PATH="/Users/satoshi/.codeium/windsurf/bin:$PATH"
