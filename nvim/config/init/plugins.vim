call plug#begin(plugged_path)

"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'vim-ctrlspace/vim-ctrlspace'        " Tabs/Buffers/Fuzzy/Workspaces/Bookmarks
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'majutsushi/tagbar'                  " Class/module browser
Plug 'szw/vim-tags'                       " Ctags generator for Vim
Plug 'tpope/vim-fugitive'                 " Git wrapper

"--------------------=== Fancy things ===----------------------------
Plug 'flazz/vim-colorschemes'             " Colorschemes
Plug 'kien/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'chriskempson/base16-vim'            " Base 16 colors
Plug 'ryanoasis/vim-devicons'             " Dev Icons
Plug 'arcticicestudio/nord-vim'           " Nord colorscheme
Plug 'ayu-theme/ayu-vim'                  " Ayu colorscheme
Plug 'mhartington/oceanic-next'           " Oceanic-next colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}     " One1/2 colorschme
Plug 'itchyny/lightline.vim'              " Light and configurable statusline/tabline
Plug 'vim-airline/vim-airline'            " Very cool status line

"--------------------=== Snippets support ===------------------------
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"--------------------=== Languages support, autocompletion ===-----------------------
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plug 'w0rp/ale'                           " Asynchronous Code Check
Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
" Plug 'jmcantrell/vim-virtualenv'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'maralla/completor.vim'              " completion
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings
" Plug 'neomake/neomake'

"--------------------=== Markdown ===-----------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"--------------------=== LaTeX ===-----------------------
Plug 'lervag/vimtex'                      " LaTeX

"--------------------=== Build ===-----------------------
Plug 'thinca/vim-quickrun'
Plug 'Shougo/vimproc.vim', {'do': 'make'}

"--------------------=== fzf (fuzzy finder) ===--------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"--------------------=== Hatena Blog ===--------------------
Plug 'mattn/webapi-vim' | Plug 'Shougo/unite.vim' | Plug 'moznion/hateblo.vim'

call plug#end()
