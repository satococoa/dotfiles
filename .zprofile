export LANG=ja_JP.UTF-8
case "${OSTYPE}" in
  darwin*)
  export PATH=$HOME/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/usr/local/share/man:/opt/local/share/man:$MANPATH
  ;;
  linux*)
  export PATH=$PATH:$HOME/bin
  export EDITOR=/usr/bin/vim
  export LS_COLORS="di=01;33"
  ;;
esac
