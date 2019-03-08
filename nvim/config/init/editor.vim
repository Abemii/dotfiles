"-------------------
" General settings
"------------

" Map semicolon to colon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Swap key map for moving display lines and logical lines
noremap j gj
noremap k gk

set guicursor=
set foldmethod=indent

" search settings
set incsearch                           " incremental search
set hlsearch                           " highlight search results

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make split and vsplit put the new buffer below and on the right of the current buffer respectively.
set splitbelow
set splitright

" Wrap lines
set wrap

" Ignore case when searching
set ignorecase

" Show whitespaces at eol
autocmd BufNewFile,BufRead * match Error /\s\+$/

" map leader
let mapleader = "\<Space>"

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set encoding=utf8
set t_Co=256
let base16colorspace=256
set background=dark
set guifont=RictyDiscordForPowerline\ Nerd\ Font:h14

"let g:loaded_python_provider=1
let g:python2_host_prog=''
let g:python3_host_prog=expand('$EXT_HOME/anaconda3/envs/neovim/bin/python3')
set shell=/bin/zsh

set hidden
set showtabline=0

set number                                " show line numbers
set ruler
set ttyfast                               " terminal acceleration

set tabstop=4                             " 4 whitespaces for tabs visual presentation
set shiftwidth=4                          " shift lines by 4 spaces
set smarttab                              " set tabs for a shifttabs logic
set expandtab                             " expand tabs into spaces
set autoindent                            " indent when moving to the next line

set cursorline                            " show line under the cursor's line
set showmatch                             " show matching part of bracket parts (), [], {}

set enc=utf-8                             " utf-8 by default

set nobackup                              " no backup files
set noswapfile

set backspace=indent,eol,start            " backspace removes all

set scrolloff=20
set clipboard=unnamed                     " use system clipboard
set listchars=tab:>\ ,trail:•,extends:#,nbsp:." Indent guides settings

" Auto update
set autoread
set autowrite

" By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
set noshowmode

syntax enable                             " enable syntaax highlighting

set laststatus=2

" ---------------------
" Window / Tab settings
" ---------------------
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w

nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sR <C-w>R

nnoremap s= <C-w>=
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

