colorscheme h2u_black
set hlsearch
set vb t_vb=
if has('gui_macvim')
    set columns=120
    set lines=36
    set imdisable
    set showtabline=2
    set transparency=5
    set antialias
    set guifont=Osaka-等幅:h11
    " set guifontwide=Osaka:h11
    set guioptions-=T
    set fileencodings=''
    " MacPortsで入れたRubyを使う
    let $RUBY_DLL = "/opt/local/lib/libruby.1.8.7.dylib"
elseif has('gui_win32')
    set guifont=MS_Gothic:h9:cSHIFTJIS
    "set guifont=M+2VM+IPAG_circle:h8:cSHIFTJIS
    set columns=140
    set lines=60
    set hlsearch
    set guioptions='m'
    set vb t_vb=
    highlight CursorLine guifg=NONE guibg=NONE gui=underline
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    set transparency=240
endif
