set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac
if has('win32')
    set termencoding=cp932
endif
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
set ts=4 sw=4 sts=4 expandtab
nnoremap <silent> <Space> :bn<CR>
nnoremap <silent> <S-Space> :bp<CR>
" for ChangeLog
let g:changelog_username="Satoshi Ebisawa <e.satoshi@gmail.com>"
" for PHP
let php_sql_query=1
let php_htmlInStrings=1
" let php_noShortTags=1
let php_folding=1
autocmd BufRead,BufNewFile *.ctp setfiletype php
" for ruby
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1
autocmd FileType ruby set ts=2 sw=2 sts=2 expandtab
" for (x)html
autocmd FileType xhtml,html set ts=2 sw=2 sts=2 expandtab
" autocmd BufNewFile *.html 0r $HOME/.vim/template/skelton.html
" for JavaScript
autocmd FileType javascript set ts=2 sw=2 sts=2 expandtab
" for scala
autocmd FileType scala set ts=2 sw=2 sts=2 expandtab
" for some plugins
" yankring
let g:yankring_max_history = 30
let g:yankring_max_display = 70
let g:yankring_history_file = '.yankring_history'
" FuzzyFinder
nnoremap <silent> ,fb :FufBuffer<CR>
nnoremap <silent> ,ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> ,fc :FufCoverageFile<CR>
nnoremap <silent> ,fd :FufDir<CR>
" Ku
nnoremap ,kb :<C-u>Ku buffer<CR>
nnoremap ,kf :<C-u>Ku file<CR>
" NERD comments
let NERDSpaceDelims = 1
let NERDShutUp = 1
" NERD Tree
nnoremap <silent> ,tt :NERDTreeToggle<CR>
" Align.vim
let g:Align_xstrlen = 3
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
imap <silent><C-l>     <Plug>(neocomplcache_snippets_expand)
smap <silent><C-l>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
inoremap <expr><silent><C-g>     neocomplcache#undo_completion()
" 途中でEnterしたとき、ポップアップを消して改行し、
" 改行を連続して入力してもインデント部を保持する
inoremap <expr><CR> pumvisible() ? "\<C-y>\<CR>X\<BS>" : "\<CR>X\<BS>"
" git-vim
nnoremap <silent> ,gd :GitDiff<CR>
nnoremap <silent> ,gD :GitDiff --cached<CR>
nnoremap <silent> ,gs :GitStatus<CR>
nnoremap <silent> ,gl :GitLog<CR>
nnoremap <silent> ,ga :GitAdd<CR>
nnoremap <silent> ,gA :GitAdd <cfile><CR>
nnoremap <silent> ,gc :GitCommit<CR>

"導入済み:surround.vim, rails.vim, vim-ruby, yankring,
"FuzzyFinder, NERD commenter, NERD Tree
"neocomplcache, scala.vim, vimproc, vimshell
"Ku, zencoding.vim, git-vim, mru.vim
