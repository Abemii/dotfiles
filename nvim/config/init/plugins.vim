call plug#begin(plugged_path)
" Make sure you use single quotes
" Add all your plugins here

"-------------------=== General ===-------------
" Completion
Plug 'maralla/completor.vim'

" " Fuzzy finder
" Plug '/bin/fzf'
" Plug 'junegunn/fzf.vim'

" Pairs
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Comment codes
Plug 'tpope/vim-commentary'

" Git wrapper
" Plugin 'tpope/vim-fugitive'

" Status line
Plug 'vim-airline/vim-airline'

" Tree explorer
Plug 'scrooloose/nerdtree'

" Tagbar
Plug 'majutsushi/tagbar'

" Markdown
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'

" LaTeX
Plug 'lervag/vimtex'

" Python Syntax
Plug 'scrooloose/syntastic'

" " Python auto completion
" Plug 'davidhalter/jedi-vim'

" Auto completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'

" Color Scheme
Plug 'jacoborus/tender.vim'
Plug 'jdkanani/vim-material-theme'

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
Plug 'w0rp/ale'

"-------------------=== Python ===----------------------------------
Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
Plug 'jmcantrell/vim-virtualenv'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


call plug#end()
