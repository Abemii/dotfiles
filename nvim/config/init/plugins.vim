call plug#begin(plugged_path)

" Make sure you use single quotes
" Add all your plugins here

" ====================
" -- Auto Complete ---
" ====================
Plug 'maralla/completor.vim'              " completion

" ====================
" -- Auto Pairs ------
" ====================
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings

" ====================
" -- Comment Out -----
" ====================
Plug 'tpope/vim-commentary'               " Comment codes


Plug 'tpope/vim-fugitive'                 " Git wrapper

Plug 'vim-airline/vim-airline'            " Very cool status line

Plug 'scrooloose/nerdtree'                " Tree explorer

Plug 'majutsushi/tagbar'                  " Where am I (funtions)

" ====================
" -- Markdown --------
" ====================
Plug 'iamcco/markdown-preview.vim'        " Markdown Preview
Plug 'iamcco/mathjax-support-for-mkdp'    " Markdown Preview (Math)

" ====================
" == LaTeX ===========
" ====================
Plug 'lervag/vimtex'                      " LaTeX
Plug 'thinca/vim-quickrun'                " LaTeX

" Python Syntax
Plug 'scrooloose/syntastic'

" Python auto completion
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'

" Color Scheme
" Plug 'jacoborus/tender.vim'
" Plug 'jdkanani/vim-material-theme'

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
Plug 'sonph/onehalf', {'rtp': 'vim/'}     " One1/2 colorschme
Plug 'mhartington/oceanic-next'           " Oceanic-next colorscheme

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


call plug#end()
