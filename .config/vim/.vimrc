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
hi cursorline guibg=#00ff00
hi CursorColumn guibg=#00ff00

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

" ---------------- Clipboard ---------------------------------
set clipboard+=unnamed

" ---------------- Cursor Shape ------------------------------
" Changed \e to \<Esc> for better compatibility in Vim script strings
let &t_SI="\<Esc>[5 q"   " insert mode (blinking bar)
let &t_SR="\<Esc>[4 q"   " replace mode (solid underline)
let &t_EI="\<Esc>[1 q"   " normal mode (blinking block)

" Fix startup cursor issue (Added the missing backslash)
autocmd VimEnter * silent! execute "normal! \<Esc>"

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
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set undodir=$XDG_CACHE_HOME/vim/undo//
set backupdir=$XDG_CACHE_HOME/vim/backup//
set directory=$XDG_CACHE_HOME/vim/swap//