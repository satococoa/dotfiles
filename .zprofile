export LANG=ja_JP.UTF-8
case "${OSTYPE}" in
  darwin*)
  export PATH=$HOME/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/Developer/SDKs/flex/bin:/Developer/SDKs/appengine-java-sdk/bin:$PATH
  export MANPATH=/usr/local/share/man:/opt/local/share/man:$MANPATH
  ;;
  linux*)
  export PATH=$PATH:$HOME/bin:$HOME/flex_sdk_3/bin:$HOME/appengine-java-sdk/bin
  export EDITOR=/usr/bin/vim
  export LS_COLORS="di=01;33"
  ;;
esac
