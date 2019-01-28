call plug#begin(plugged_path)

"--------------------=== Auto Complete ===--------------------
Plug 'maralla/completor.vim'              " completion

"--------------------=== Auto Pairs ===--------------------
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings

" -- Comment Out -----
Plug 'tpope/vim-commentary'               " Comment codes


Plug 'tpope/vim-fugitive'                 " Git wrapper

Plug 'vim-airline/vim-airline'            " Very cool status line

Plug 'scrooloose/nerdtree'                " Tree explorer


" -- Markdown --------
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" == LaTeX ===========
Plug 'lervag/vimtex'                      " LaTeX
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" -- build -------------
Plug 'thinca/vim-quickrun'                " LaTeX
Plug 'Shougo/vimproc.vim', {'do': 'make'}

" This is the culprit of slowing the vim when saved
" " Python Syntax
" Plug 'scrooloose/syntastic'

" Python auto completion
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'


"-------------------=== Code/Project navigation ===-------------

Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'neomake/neomake'                    " Asynchronous Linting and Make Framework
Plug 'Shougo/deoplete.nvim'               " Asynchronous Completion
Plug 'vim-ctrlspace/vim-ctrlspace'        " Tabs/Buffers/Fuzzy/Workspaces/Bookmarks
Plug 'mileszs/ack.vim'                    " Ag/Grep
" Uncomment if you want to use vim-airline over lightline
" Plug 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
" Plug 'vim-airline/vim-airline-themes'     " Themes for airline
Plug 'itchyny/lightline.vim'
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'majutsushi/tagbar'                  " Class/module browser

"-------------------=== Fancy things ===----------------------------
Plug 'flazz/vim-colorschemes'             " Colorschemes
Plug 'jreybert/vimagit'                   " Git Operations
Plug 'kien/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'chriskempson/base16-vim'            " Base 16 colors
Plug 'ryanoasis/vim-devicons'             " Dev Icons
Plug 'arcticicestudio/nord-vim'           " Nord colorscheme
Plug 'ayu-theme/ayu-vim'                  " Ayu colorscheme
Plug 'mhartington/oceanic-next'           " Oceanic-next colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}     " One1/2 colorschme

"-------------------=== Snippets support ===------------------------
Plug 'honza/vim-snippets'                 " snippets repo
Plug 'Raimondi/delimitMate'               " Auto-close brackets

"-------------------=== Languages support ===-----------------------
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plug 'w0rp/ale'                           " Asynchronous Code Check

"-------------------=== Python ===----------------------------------
Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
Plug 'jmcantrell/vim-virtualenv'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
