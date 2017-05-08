# tmux 自動起動
if test $TERM != "screen"
  if tmux has-session ^ /dev/null
    set session (tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]*\).*$/\1/')
    if test -n $session
      echo "Attach tmux session $session"
      exec tmux attach-session -t $session
    else
      echo "Session has been already attached."
      tmux list-sessions
    end
  else
    exec tmux
  end
end

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'yes'
set -g __fish_git_prompt_showupstream 'auto'
set -g __fish_git_prompt_show_informative_status 'yes'

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'

set -x EDITOR /usr/bin/vi
set -x BUNDLE_JOBS 4
set -U fish_user_paths /usr/local/bin

# golang
set -x GOPATH $HOME/dev
set -U fish_user_paths $GOPATH/bin $fish_user_paths

# ruby
set -x CONFIGURE_OPTS '--disable-install-rdoc'
# set openssl_prefix (brew --prefix openssl)
# set readline_prefix (brew --prefix readline)
set openssl_prefix /usr/local/opt/openssl
set readline_prefix /usr/local/opt/readline
set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=$openssl_prefix --with-readline-dir=$readline_prefix"
set -x RUBY_MAKE_OPTS '-j 2'

# java
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths

# anyenv
set -U fish_user_paths $HOME/.anyenv/bin $fish_user_paths
status --is-interactive; and source (anyenv init -|psub)

# direnv
eval (direnv hook $SHELL)

# aws-cli
if test -x (which aws_completer)
  complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end
