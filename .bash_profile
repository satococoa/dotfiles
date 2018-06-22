export EDITOR=/usr/bin/vim
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
export GOPATH="$HOME/dev"
export PATH=$PATH:$GOPATH/bin
export BUNDLE_JOBS=4

# *env
export CONFIGURE_OPTS='--disable-install-rdoc'
# brew --prefix openssl
openssl_path=/usr/local/opt/openssl
# brew --prefix readline
readline_path=/usr/local/opt/readline
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$openssl_path --with-readline-dir=$readline_path --disable-dtrace"
export RUBY_MAKE_OPTS='-j 2'
export PATH=$HOME/.anyenv/bin:$PATH

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi
