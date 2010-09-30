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
    set guifont=VL\ Gothic\ Regular:h13
    set guifontwide=VL\ Gothic\ Regular:h13
    set guioptions-=T
    set fileencodings=''
    " rvmで入れたRubyを使う
    let $RUBY_DLL = $HOME.'/.rvm/rubies/ruby-1.8.7-p302/lib/libruby.dylib'
elseif has('gui_win32')
    set guifont=MS_Gothic:h9:cSHIFTJIS
    "set guifont=M+2VM+IPAG_circle:h8:cSHIFTJIS
    set columns=140
    set lines=60
    set hlsearch
    set guioptions='m'
    set vb t_vb=
    highlight CursorLine guifg=NONE guibg=NONE gui=underline
    let g:git_bin='C:/Git/bin/git.exe'
    let $PATH = $PATH.';C:/Ruby192/bin'
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    set transparency=240
endif
