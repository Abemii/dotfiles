" --------------------
"  Mapping
" --------------------

" map leader
let mapleader = "\<Space>"

" Map semicolon to colon for ASCII keyboard.
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Swap key map for moving display lines and logical lines
noremap j gj
noremap k gk

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Window / Tab settings
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
nnoremap s> 5<C-w>>
nnoremap s< 5<C-w><
nnoremap s+ 5<C-w>+
nnoremap s- 5<C-w>-

nnoremap st :tabnew<CR>
nnoremap sn gt
nnoremap sp gT


" --------------------
" General settings
" --------------------

" window settings
set number                                       " show line numbers
set laststatus=2                                 " always show status line
set showmatch                                    " show matching part of bracket parts (), [], {}
set ruler                                        " show cursor place at the bottom bar.
set noshowmode                                   " do not show mode (--INSERT--)
set showtabline=0
set scrolloff=20
autocmd BufNewFile,BufRead * match Error /\s\+$/ " Show whitespaces at eol
set foldmethod=indent                            " more indent means a higher fold level
set nowrap                                       " Wrap lines
set guicursor=                                   " no special cursor in neovim
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
let base16colorspace=256
set background=dark
" Make split and vsplit put the new buffer below and on the right of the current buffer respectively.
set splitbelow
set splitright
set encoding=utf8
set t_Co=256
set pumblend=10                                  " transparent

if !has('gui_running')
    augroup guake
        autocmd!
        autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight Folded ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight CursorLineNr ctermbg=none guibg=none
        autocmd VimEnter,ColorScheme * highlight TablineSel ctermbg=none guibg=none
    augroup END
endif

" Search/Replace
set incsearch                                    " incremental search
set hlsearch                                     " highlight search results
set ignorecase                                   " Ignore case when searching

let g:python2_host_prog=''
let g:python3_host_prog=$PYTHON3_HOST_PROG
set shell=zsh

" File processing
set hidden                                       " can open new file even if current file is not saved
set nobackup                                     " no backup files
set noswapfile

set ttyfast                                      " terminal acceleration
set clipboard=unnamedplus                        " use system clipboard

" tab/indent
set tabstop=4                                    " 4 whitespaces for tabs visual presentation
set shiftwidth=4                                 " shift lines by 4 spaces
set smarttab                                     " set tabs for a shifttabs logic
set expandtab                                    " expand tabs into spaces
set autoindent                                   " indent when moving to the next line
set backspace=indent,eol,start                   " backspace removes all
set listchars=tab:>\ ,trail:•,extends:#,nbsp:.   " Indent guides settings

" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" Auto update
set autoread
set autowrite

" Automatically check file updates when enter in window.
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

syntax enable                                    " enable syntax highlighting
