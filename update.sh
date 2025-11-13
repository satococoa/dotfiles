#!/usr/bin/env zsh

set -euo pipefail

DOTFILES_DIR="$HOME/dev/src/github.com/satococoa/dotfiles"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Updating dotfiles repository..."
(cd "$DOTFILES_DIR" && git pull)

echo "Updating Homebrew packages..."
brew update || echo "Warning: brew update failed"
brew upgrade || echo "Warning: brew upgrade failed"

if [[ -f "$BREWFILE" ]]; then
    echo "Applying Brewfile..."
    brew bundle --file "$BREWFILE" || echo "Warning: brew bundle failed"
else
    echo "Brewfile not found at $BREWFILE"
fi

echo "Updating mise packages..."
mise up || echo "Warning: mise up failed"

echo "Updates completed successfully!"
