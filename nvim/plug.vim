" --------------------
"  Vim-Plug settings
" --------------------

call plug#begin(plugged_path)

"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plug 'majutsushi/tagbar'                  " Class/module browser
Plug 'szw/vim-tags'                       " Ctags generator for Vim
Plug 'tpope/vim-fugitive'                 " Git wrapper
Plug 'kassio/neoterm'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" --------------------
" Fancy appearance
" --------------------
Plug 'sonph/onehalf', {'rtp': 'vim/'}     " Atom based color scheme
Plug 'kien/rainbow_parentheses.vim'       " Highlights matching parenthesis with a rainbow of colors
Plug 'ryanoasis/vim-devicons'             " Dev Icons
Plug 'vim-airline/vim-airline'            " Very cool status line
Plug 'vim-airline/vim-airline-themes'     " Very cool status line theme

" --------------------
" Language support, auto completion
" --------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'dense-analysis/ale'                           " Asynchronous Code Check (do not use coc for lint/fix)
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings
Plug 'junegunn/vim-easy-align'            " a simple, easy-to-use Vim alignment plugin.
Plug 'terryma/vim-multiple-cursors'       " multiple selection
Plug 'kamykn/spelunker.vim'               " spell check
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " syntax highlight for python

" --------------------
" Markdown 
" --------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" --------------------
" Build 
" --------------------
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}

call plug#end()
