export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
if [ -f ~/.bash/git-completion.bash ]; then
  source ~/.bash/git-completion.bash
  PS1="\h:\W\$(__git_ps1) \u\$ "
fi

alias r='rails'
alias g='git'
alias titanium="$HOME/Library/Application\ Support/Titanium/mobilesdk/osx/1.7.2/titanium.py"

# for ruby-build
export CONFIGURE_OPTS='--enable-shared'
if [ -f ~/.rbenv/completions/rbenv.bash ]; then
  source ~/.rbenv/completions/rbenv.bash
fi
