#!/bin/zsh

set -e  # エラーが発生した時点でスクリプトを終了

DIR=$(cd $(dirname $0); pwd)

# Homebrew の存在確認
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# シンボリックリンクを作成する関数
create_symlink() {
    local source=$1
    local target=$2

    if [[ -L $target ]]; then
        echo "Removing existing symlink: $target"
        unlink $target
    elif [[ -e $target ]]; then
        echo "Removing existing file/directory: $target"
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

# .config/ ディレクトリのシンボリックリンク
mkdir -p ~/.config
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
for brew in ${brews[@]}; do
    if brew list $brew &>/dev/null; then
        echo "$brew is already installed"
    else
        echo "Installing $brew ..."
        brew install $brew
    fi
done

# Homebrew Cask パッケージのインストール
casks=(1password appcleaner discord figma google-chrome imageoptim raindropio visual-studio-code zed font-udev-gothic)
for cask in ${casks[@]}; do
    if brew list --cask $cask &>/dev/null; then
        echo "$cask is already installed"
    else
        echo "Installing $cask ..."
        brew install --cask $cask
    fi
done

echo "Setup completed successfully!"
