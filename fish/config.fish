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

# aliases
alias r='rails'
alias g='git'
alias be='bundle exec'

# env
set -x EDITOR /usr/bin/vi
set -x BUNDLE_JOBS 4
set -U fish_user_paths /usr/local/bin

# golang
set -x GOPATH $HOME/dev
set -U fish_user_paths $GOPATH/bin $fish_user_paths

# ruby
set -x CONFIGURE_OPTS '--disable-install-rdoc'
set openssl_prefix (brew --prefix openssl)
set readline_prefix (brew --prefix readline)
set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=$openssl_prefix --with-readline-dir=$readline_prefix"
set -x RUBY_MAKE_OPTS '-j 2'

# direnv
eval (direnv hook $SHELL)

# aws-cli
if test -x (which aws_completer)
  complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end

# peco
# https://github.com/oh-my-fish/plugin-peco/blob/master/functions/peco_select_history.fish
function peco_select_history
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function peco_select_repository
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  ghq list --full-path|peco $peco_flags|read foo

  if [ $foo ]
    cd $foo
    commandline -f repaint
    emit fish_prompt
  else
    commandline ''
  end
end

function fish_user_key_bindings
  bind \cr peco_select_history
  bind \c] peco_select_repository
end

function fish_prompt
  if test $status -eq 0
    set_color green
    printf '%s ' "☀"
  else
    set_color blue
    printf '%s ' "☂"
  end
end

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'auto'
set __fish_git_prompt_show_informative_status 'yes'

function fish_right_prompt
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s' (__fish_git_prompt)

  set_color normal
end
