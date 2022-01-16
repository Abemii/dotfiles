" --------------------
"  Vim-Plug settings
" --------------------

call plug#begin(plugged_path)

"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
" Plug 'majutsushi/tagbar'                  " Class/module browser
Plug 'szw/vim-tags'                       " Ctags generator for Vim
Plug 'liuchengxu/vista.vim'               " View and search LSP symbols, tags in Vim/NeoVim.
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
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings
Plug 'junegunn/vim-easy-align'            " a simple, easy-to-use Vim alignment plugin.
Plug 'terryma/vim-multiple-cursors'       " multiple selection
Plug 'kamykn/spelunker.vim'               " spell check
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }  " auto completion of pydocstring
Plug 'chiphogg/vim-prototxt'              " syntax highlight for caffe prototxt files
Plug 'APZelos/blamer.nvim'                " VS Code's GitLens
Plug 'antoyo/vim-licenses'

" --------------------
" Markdown 
" --------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jszakmeister/markdown2ctags'

" --------------------
" Build 
" --------------------
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}

call plug#end()
