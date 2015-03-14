set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
set nocompatible
set vb t_vb=
set ruler
set laststatus=2
set backspace=2
set wrapscan
set wildmenu
set incsearch
set ignorecase
set smartcase
set hlsearch
set nobackup
set noswapfile
set viminfo+=!
set hidden
set number
set wrap
set list
set listchars=tab:>-
set cursorline
set showcmd
set title
set nopaste
set autoread
set background=dark
highlight Pmenu ctermbg=lightcyan ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray
syntax enable
filetype on
filetype indent on
filetype plugin on
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
set showmatch
set modeline
set modelines=5
set cmdheight=1
set ts=2 sw=2 sts=2 expandtab
" for ChangeLog
let g:changelog_username="Satoshi Ebisawa <e.satoshi@gmail.com>"
" for PHP
let php_folding=1
autocmd FileType php set ts=4 sw=4 sts=4 expandtab
autocmd BufRead,BufNewFile *.ctp setfiletype php
" for ruby
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1
" for some plugins
" yankring
let g:yankring_max_history = 30
let g:yankring_max_display = 70
let g:yankring_history_file = '.yankring_history'
" no un~ file
set noundofile
