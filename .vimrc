"Vundle
set rtp+=~/.vim/vundle/
call vundle#rc()

" Bundles
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'rails.vim'
Bundle 'eregex.vim'
Bundle 'matchit.zip'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'surround.vim'
Bundle 'ZenCoding.vim'
Bundle 'YankRing.vim'

Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'motemen/git-vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/vim-alignta'
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'ujihisa/shadow.vim'

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
set modelines=5
set ts=2 sw=2 sts=2 expandtab
nnoremap <silent> <Space> :bn<CR>
nnoremap <silent> <S-Space> :bp<CR>
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
" FuzzyFinder
nnoremap <silent> ,fb :FufBuffer<CR>
nnoremap <silent> ,ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> ,fc :FufCoverageFile<CR>
nnoremap <silent> ,fd :FufDir<CR>
" NERD comments
let NERDSpaceDelims = 1
let NERDShutUp = 1
" NERD Tree
nnoremap <silent> ,tt :NERDTreeToggle<CR>
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
" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> <space>b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <space>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <space>r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <space>m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <space>u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> <space>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" zencoding
let g:user_zen_settings = { 'indentation': '  ' }
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}
