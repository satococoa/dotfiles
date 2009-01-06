highlight CursorLine guifg=NONE guibg=NONE gui=underline
colorscheme xoria256
set hlsearch
" set guioptions='Tm'
set vb t_vb=
if has('gui_macvim')
    set columns=140
    set lines=60
    set imdisable
    set showtabline=2
    set transparency=10
    set antialias
    set guifont=Monaco:h12
else
    set columns=140
    set lines=60
    set guifont=Osaka-Mono:h14
    set iminsert=0 imsearch=0 noimdisable
    " set transparency=230
    set transparency=240
endif
