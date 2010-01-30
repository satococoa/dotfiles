export LANG=ja_JP.UTF-8
case "${OSTYPE}" in
  darwin*)
  export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:/Developer/SDKs/flex/bin:$PATH
  export MANPATH=/usr/local/share/man:/opt/local/share/man:$MANPATH
  ;;
  linux*)
  export PATH=$PATH:$HOME/flex_sdk_3/bin
  export EDITOR=/usr/bin/vim
  export LS_COLORS="di=01;33"
  ;;
esac