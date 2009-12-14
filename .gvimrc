colorscheme h2u_black
set hlsearch
set vb t_vb=
if has('gui_macvim')
    set columns=120
    set lines=36
    set imdisable
    set showtabline=2
    set transparency=10
    set antialias
    set guifont=Monaco:h11
    set guioptions-=T
    set fileencodings=''
    " MacPortsで入れたRubyを使う
    let $RUBY_DLL = "/opt/local/lib/libruby.1.8.7.dylib"
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    set transparency=240
endif
