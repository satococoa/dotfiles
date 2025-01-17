#!/usr/bin/env zsh

set -euo pipefail

echo "Updating dotfiles repository..."
(cd "$HOME/dev/src/github.com/satococoa/dotfiles" && git pull)

echo "Updating Homebrew packages..."
brew update || echo "Warning: brew update failed"
brew upgrade || echo "Warning: brew upgrade failed"

echo "Updating mise packages..."
mise up || echo "Warning: mise up failed"

echo "Updates completed successfully!"
