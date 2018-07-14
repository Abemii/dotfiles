"---------- Editor Preferences ----------"
" Color scheme
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
set background=dark
color material-theme

" Show line number
set number
set mouse=a

set guicursor=
set clipboard+=unnamedplus
set foldmethod=indent

" highlight search matches
set hlsearch

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 1 tab is 4 spaces
set shiftwidth=4
set tabstop=4
set smarttab
" Use spaces instead of tabs
set expandtab

" Wrap lines
set wrap

" Ignore case when searching
set ignorecase

" Show whitespaces at eol
autocmd BufNewFile,BufRead * match Error /\s\+$/



"-------------------
" General settings
"------------
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
set encoding=utf8
set t_Co=256
let base16colorspace=256
set background=dark
set guifont=DroidSansMono\ Nerd\ Font\ 12
" NOTE: This is only compatible with Guake 3.X.
" Check issue: https://github.com/Guake/guake/issues/772
if (has("termguicolors"))
   set termguicolors
endif

colorscheme onehalfdark
" colorscheme ayu
" let ayucolor="dark"
syntax enable                             " enable syntaax highlighting

"let g:loaded_python_provider=1
let g:python2_host_prog='/usr/bin/python'
let g:python3_host_prog='/Users/abemi/.pyenv/versions/anaconda3-5.0.0/bin/python'
set shell=/usr/local/bin/fish
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

" Uncomment it if you want to use mouse
" if has('mouse')
"     set mouse=a
" endif

" By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
set noshowmode

" -----------------------
" Tab / Buffers settings
" ----------------------
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q: SyntasticCheck # <CR> :bp <BAR> bd #<CR>
