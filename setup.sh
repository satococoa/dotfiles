#!/usr/bin/env zsh

set -euo pipefail

DIR=$(cd "$(dirname "$0")" && pwd)
BREWFILE="$DIR/Brewfile"

# Homebrewパスの設定
if [[ $(uname -m) == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
BREW_PATH="$BREW_PREFIX/bin/brew"

# Homebrewのインストールチェックと提案
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Would you like to install it now? (y/n)"
    read -r answer
    if [[ $answer == "y" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is required for this script. Exiting."
        exit 1
    fi
fi

# HomebrewのENV設定
if [[ -x $BREW_PATH ]]; then
    eval "$($BREW_PATH shellenv)"
fi

# シンボリックリンクを作成する関数
create_symlink() {
    local source=$1
    local target=$2

    if [[ -L $target || -e $target ]]; then
        echo "Removing existing file/symlink: $target"
        rm -rf $target
    fi

    echo "Creating symlink: $source -> $target"
    ln -s $source $target
}

# ホームディレクトリのファイル
files=(update.sh .zshrc .zprofile .tmux.conf)
for file in ${files[@]}; do
    create_symlink $DIR/$file ~/$file
done

# ~/.config ディレクトリを一度だけ作成
mkdir -p ~/.config

# .config/ ディレクトリのシンボリックリンク
config_dirs=(git alacritty ghostty nvim)
for config_dir in ${config_dirs[@]}; do
    create_symlink $DIR/$config_dir ~/.config/$config_dir
done

# .config/ 内の特定ファイルのシンボリックリンク
config_files=(zed/settings.json zed/keymap.json)
for config_file in ${config_files[@]}; do
    mkdir -p ~/.config/$(dirname $config_file)
    create_symlink $DIR/$config_file ~/.config/$config_file
done

# ~/.claude/ ディレクトリのシンボリックリンク
mkdir -p ~/.claude
create_symlink $DIR/claude/settings.json ~/.claude/settings.json

# Brewfile の適用
if [[ -f "$BREWFILE" ]]; then
    echo "Installing Homebrew packages from Brewfile..."
    brew bundle --file "$BREWFILE" --no-lock
else
    echo "Brewfile not found at $BREWFILE. Skipping brew bundle."
fi

echo "Setup completed successfully!"
