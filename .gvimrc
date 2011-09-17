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
    set guifont=VL\ Gothic\ Regular:h14
    set guifontwide=VL\ Gothic\ Regular:h14
    set guioptions-=T
    set fileencodings=''
    " let $RUBY_DLL = $HOME.'/.rvm/rubies/ruby-1.9.2-p0/lib/libruby.dylib'
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    set transparency=240
endif
