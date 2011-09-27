colorscheme railscasts
set hlsearch
set vb t_vb=
if has('gui_macvim')
    set columns=100
    set lines=40
    set imdisable
    set showtabline=2
    set transparency=5
    set antialias
    " set guifont=VL\ Gothic\ Regular:h14
    " set guifontwide=VL\ Gothic\ Regular:h14
    set guifont=Ricty:h16
    set guifontwide=Ricty:h16
    set linespace=2
    set guioptions-=T
    set fileencodings=''
    let $RUBY_DLL = $HOME.'/.rbenv/versions/1.9.3-preview1/lib/libruby.dylib'
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    set transparency=240
endif
