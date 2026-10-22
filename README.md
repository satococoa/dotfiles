# dotfiles

Apple Silicon Mac の開発環境を mise bootstrap で管理する。
Homebrew 本体は残し、mise 本体は `~/.local/bin/mise` に直接インストールする。

## 管理するもの

- `mise.toml`: 共通 CLI・フォントと設定ファイルの配備先。
- zsh、Git、Ghostty、Zed の設定。Git の既定メールは個人メール。
- Homebrew formula の CLI に加え、cask の 1Password CLI とフォント
  （Guguru Sans Code、JetBrains Mono、UDEV Gothic）も管理する。

デスクトップアプリ・Mac App Store アプリは管理対象外。
言語ランタイムや mise ツールは各マシンで `mise use -g` を使って設定する。
会社固有のメール、認証情報、`~/.gitconfig` は管理しない。

## Playbook: 初回セットアップ

1. [Homebrew](https://brew.sh/) をインストールする。Command Line Tools と
   Homebrew のインストーラーが案内する shellenv の設定も済ませる。
2. [mise](https://mise.jdx.dev/installing-mise.html) を直接インストールする。

   ```sh
   curl -fsSL https://mise.run | sh
   export PATH="$HOME/.local/bin:$PATH"
   ```

3. このリポジトリを取得する。

   ```sh
   git clone https://github.com/satococoa/dotfiles.git \
     ~/dev/src/github.com/satococoa/dotfiles
   cd ~/dev/src/github.com/satococoa/dotfiles
   mise trust
   mise bootstrap --dry-run
   mise bootstrap
   ```

4. 新しいターミナルを開いて `mise doctor` を確認する。

mise 2026.10.17 以降が必要。すでに設定やリンクがある場合は差分を確認して統合する。
`--force-dotfiles` で一律に上書きしない。
必要なランタイムは、その Mac で個別に追加する（「ランタイム・mise ツールの追加」を参照）。

## Playbook: 職場マシンのセットアップ

職場 Mac も「初回セットアップ」を実行する。共有する設定・パッケージは同じで、
Git のメールアドレスだけをローカル設定で切り替える。

bootstrap は個人・会社で同じ。会社 Mac だけ、通常ファイル `~/.gitconfig` に
以下を追加する。既存ファイルがあれば他の設定を保って統合する。

```gitconfig
[user]
    email = 会社メール

[includeIf "gitdir:~/dev/src/github.com/satococoa/"]
    path = ~/.config/git/personal
```

`~/.config/git/config` の個人メールを `~/.gitconfig` の会社メールで上書きし、
個人リポジトリではリポジトリ管理の `git/personal` を読み込んで個人メールへ戻す。
`~/.config/git` はリポジトリへのリンクなので、その中へ会社固有の設定を書かない。
個人 Mac には追加設定も includeIf も不要。

`gitdir:` は作業ディレクトリではなく Git 管理ディレクトリで判定する。
linked worktree を別の場所に作っても、元リポジトリの所属に沿ってメールが決まる。
環境変数に設定した `GIT_AUTHOR_EMAIL` / `GIT_COMMITTER_EMAIL` は外し、新しいシェルで
会社・個人リポジトリとそれぞれの worktree を確認する。

```sh
git config --show-origin --get-all user.email
git var GIT_AUTHOR_IDENT
git var GIT_COMMITTER_IDENT
```

## Playbook: 日々のアップデート

以下の短いコマンド例は、`cd ~/dev/src/github.com/satococoa/dotfiles` 後に実行する。
設定と不足パッケージを反映する場合は `mise bootstrap` を実行する。
日常の更新は次のコマンドを使う。

```sh
mise -C ~/dev/src/github.com/satococoa/dotfiles run update
```

未コミット変更があれば停止する。`git pull --ff-only` → mise 本体の更新 →
新しい設定の再読み込み → bootstrap → 宣言した CLI・フォントの更新 → その Mac の mise ツールの更新、
の順に実行する。途中で失敗すれば非ゼロで終了する。
手動追加した Homebrew パッケージを一括更新・削除しない。依存の更新は行われる場合がある。

リポジトリ更新なしで現在の設定を適用・更新する場合は `mise run apply-updates` を使う。
失敗時は原因を直し、同じコマンドを再実行する。未コミット変更がある場合は、まず差分を
確認してコミットするか、一時的に stash する。自分の変更を別の Mac に届けるには push も必要。

定期実行・ショートカットには、次の絶対パスのコマンドを使う
（`~` を展開しないスケジューラーでは、その Mac のホームの絶対パスに置き換える）。

```sh
$HOME/.local/bin/mise -C "$HOME/dev/src/github.com/satococoa/dotfiles" run update
```

スケジューラーの環境には Homebrew の `/opt/homebrew/bin` と `/opt/homebrew/sbin` も含める。

## Playbook: パッケージの追加

すべての Mac に再現したいものだけ、dotfiles の管理下に追加する。
以下は dotfiles の checkout 内で実行する。パッケージ名は実際に必要なものへ置き換える。

| 用途 | 追加先 | 方法 |
| --- | --- | --- |
| マシンごとのランタイム・mise ツール | ローカルの global 設定 | `mise use -g` |
| 共通 CLI・フォント・システムライブラリ | `mise.toml` の `[bootstrap.packages]` | Homebrew |
| プロジェクト固有のランタイム | そのプロジェクトの `mise.toml` | mise |
| この Mac だけの CLI・試用するツール | dotfiles へ記録しない | Homebrew 等で手動 |

### 管理下に追加する

Homebrew の共通パッケージは、次のコマンドで宣言とインストールを行う。
すでに手動導入済みでも、同じコマンドで管理下へ加えられる。

```sh
mise bootstrap packages use brew:パッケージ名
```

cask で配布される CLI・フォントも同じ方法で追加する。
デスクトップアプリはここへ登録しない。

```sh
mise bootstrap packages use brew-cask:フォント名またはCLI名
```

追加後は差分と動作を確認して共有する。

```sh
mise bootstrap --dry-run
mise bootstrap
git diff -- mise.toml
git add mise.toml
git commit -m "Add shared development tool"
git push
```

別の Mac は日々の更新コマンドで取り込める。

### ランタイム・mise ツールの追加

必要なものを各マシンで選ぶ。dotfiles には記録しない。

```sh
mise use -g node@lts ruby@latest
# 必要に応じて追加
mise use -g go@latest deno@latest uv@latest npm:@openai/codex@latest
```

プロジェクト固有のバージョンは、そのプロジェクトで `mise use ruby@3.4` 等を実行する。
プロジェクトの指定が、その Mac の global 設定より優先される。

### 管理下に入れず追加する

```sh
brew install パッケージ名
```

これらは dotfiles に自動登録されない。手動導入した formula の更新は
`brew upgrade パッケージ名`、削除は `brew uninstall パッケージ名` で個別に行う。

共通の更新タスクは、手動導入した Homebrew パッケージの一括アップグレードや削除をしない。
ただし共通パッケージの依存として更新されることはある。また `mise upgrade` は有効な
ローカル global 設定のツールも更新対象になるため、「この Mac だけの mise ツール」も更新され得る。

### 管理から外す

該当する宣言を削除してコミット・push するだけでは、インストール済みの実体は削除されない。
不要になった実体は各 Mac で依存・用途を確認して個別に削除する。

## スキルの配備

この Playbook は README を正本とし、専用の agent skill は作らない。

自作スキルを管理する場合は、スキル本体をリポジトリに収録し、`[dotfiles]` に
スキル単位のリンクを追加する。外部インストーラーのスキルとは共存させる。
現時点ではスキルの収録・自動配備は行っていない。

```toml
[dotfiles]
"~/.agents/skills/my-skill" = "agents/skills/my-skill"
```

参考: [mise bootstrap 公式リファレンス](https://mise.jdx.dev/cli/bootstrap.html)。
