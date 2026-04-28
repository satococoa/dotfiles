#!/usr/bin/env zsh

set -euo pipefail

DOTFILES_DIR="$HOME/dev/src/github.com/satococoa/dotfiles"
BREWFILE="$DOTFILES_DIR/Brewfile"

sync_agent_skills() {
    local source_dir="$DOTFILES_DIR/.agents/skills"
    local target_dir="$HOME/.agents/skills"

    if [[ ! -d "$source_dir" ]]; then
        return
    fi

    mkdir -p "$target_dir"

    for skill in "$source_dir"/*; do
        if [[ ! -d "$skill" || ! -f "$skill/SKILL.md" ]]; then
            continue
        fi

        local name
        name="$(basename "$skill")"
        local target="$target_dir/$name"

        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "Warning: $target exists and is not a symlink. Skipping."
            continue
        fi

        echo "Linking agent skill: $name"
        ln -sfn "$skill" "$target"
    done
}

echo "Updating dotfiles repository..."
(cd "$DOTFILES_DIR" && git pull)

echo "Syncing agent skills..."
sync_agent_skills

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
