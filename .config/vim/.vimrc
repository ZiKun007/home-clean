" ---------------- Key mappings -----------------------------
" Insert mode escape
inoremap jk <ESC>

" Navigation improvements
nnoremap L $
vnoremap L $
nnoremap H ^
vnoremap H ^

" Quick commands (optional: keep your old wq mapping if you still want it)
nnoremap wq :wq!<CR> 
nnoremap dL d$
nnoremap dH d^

" ---------------- UI Settings ------------------------------
syntax enable
set cursorline
hi cursorline guibg=#2d2d2d
hi CursorColumn guibg=#2d2d2d

" Colors & font
set background=dark
set guifont=Courier_New:h10:cANSI

" Line numbers
set number

" Ruler and command line
set ruler
set cmdheight=1

" Mouse
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" ---------------- Indentation ------------------------------
set expandtab
autocmd FileType makefile set noexpandtab

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set cindent
set smartindent

" ---------------- Search -----------------------------------
set hlsearch
set incsearch
set ignorecase

" ---------------- File & Encoding ---------------------------
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set langmenu=zh_CN.UTF-8
set helplang=cn

" No backup or swap files
set nobackup
set noswapfile

set autowrite
set hidden

set wildmenu
set wildmode=longest:full,full

set updatetime=50

" ---------------- Clipboard ---------------------------------
if has('unnamedplus')
  set clipboard+=unnamedplus
else
  set clipboard+=unnamed
endif

" ---------------- Cursor Shape ------------------------------
set ttimeout
set ttimeoutlen=50

if has('gui_running')
  let &t_SI="\e[5 q"
  let &t_SR="\e[3 q"
  let &t_EI="\e[2 q"
else
  let &t_SI="\e[1 q"
  let &t_SR="\e[4 q"
  let &t_EI="\e[2 q"
endif

" Fix startup cursor issue
autocmd VimEnter * silent! execute "normal! \e"

" ---------------- History & Misc ----------------------------
set history=1000
set showcmd
set magic
set noerrorbells
set novisualbell
set showmatch
set mat=2

" Prevent GUI toolbars
set guioptions-=T
set guioptions-=m

" ---------------- Cache directories -------------------------
if has('vim_starting')
  let $XDG_CACHE_HOME = exists($XDG_CACHE_HOME) ? $XDG_CACHE_HOME : $HOME . '/.cache'
endif

let s:vim_cache = $XDG_CACHE_HOME . '/vim'
call mkdir(s:vim_cache, 'p')
call mkdir(s:vim_cache . '/undo', 'p')
call mkdir(s:vim_cache . '/backup', 'p')
call mkdir(s:vim_cache . '/swap', 'p')

set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set undodir=$XDG_CACHE_HOME/vim/undo//
set backupdir=$XDG_CACHE_HOME/vim/backup//
set directory=$XDG_CACHE_HOME/vim/swap//