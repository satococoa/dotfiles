#!/usr/bin/env zsh

set -euo pipefail

DIR=$(cd $(dirname $0); pwd)

# Homebrewのインストールチェックと提案
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Would you like to install it now? (y/n)"
    read answer
    if [[ $answer == "y" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is required for this script. Exiting."
        exit 1
    fi
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
files=(update.sh .zshrc)
for file in ${files[@]}; do
    create_symlink $DIR/$file ~/$file
done

# ~/.config ディレクトリを一度だけ作成
mkdir -p ~/.config

# .config/ ディレクトリのシンボリックリンク
config_dirs=(git alacritty zellij)
for config_dir in ${config_dirs[@]}; do
    create_symlink $DIR/$config_dir ~/.config/$config_dir
done

# .config/ 内の特定ファイルのシンボリックリンク
config_files=(zed/settings.json zed/keymap.json)
for config_file in ${config_files[@]}; do
    mkdir -p ~/.config/$(dirname $config_file)
    create_symlink $DIR/$config_file ~/.config/$config_file
done

# Homebrew パッケージのインストール
brews=(ghq git jq peco direnv zsh-completions zellij asdf pure go ripgrep docker docker-compose)
echo "Installing Homebrew packages..."
brew install ${brews[@]}

# Homebrew Cask パッケージのインストール
casks=(1password appcleaner discord figma google-chrome imageoptim raindropio visual-studio-code zed font-udev-gothic)
echo "Installing Homebrew Cask packages..."
brew install --cask ${casks[@]}

echo "Setup completed successfully!"
