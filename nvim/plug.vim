" --------------------
"  Vim-Plug settings
" --------------------

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!sh -c "curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" --------------------
" General
" --------------------
Plug 'vim-denops/denops.vim'  " required for deno/ts/js
Plug 'nvim-lua/plenary.nvim'  " required for lua

"-------------------=== Code/Project navigation ===-------------
" Plug 'scrooloose/nerdtree'                " Project and file navigation
" Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'lambdalisue/fern.vim', {'branch': 'main'}               " tree viewer
Plug 'lambdalisue/fern-renderer-nerdfont.vim'  " filetype icon
Plug 'lambdalisue/fern-git-status.vim'    " add git status
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
" Plug 'majutsushi/tagbar'                  " Class/module browser
" Plug 'szw/vim-tags'                       " Ctags generator for Vim
Plug 'liuchengxu/vista.vim'               " View and search LSP symbols, tags in Vim/NeoVim.
Plug 'tpope/vim-fugitive'                 " Git wrapper
" Plug 'airblade/vim-gitgutter'
Plug 'kassio/neoterm'
Plug 'ggandor/lightspeed.nvim'
Plug 'tpope/vim-repeat'
Plug 'ekickx/clipboard-image.nvim'


" --------------------
" fuzzy finder
" --------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Plug 'Shougo/ddu.vim'
" Plug 'Shougo/ddu-ui-ff'
" Plug 'Shougo/ddu-source-file_rec'
" Plug 'Shougo/ddu-filter-matcher_substring'
" Plug 'Shougo/ddu-kind-file'


" --------------------
" Fancy appearance
" --------------------
" Plug 'sonph/onehalf', {'rtp': 'vim/'}     " Atom based color scheme
Plug 'joshdick/onedark.vim'                 " I prefer this
Plug 'kien/rainbow_parentheses.vim'         " Highlights matching parenthesis with a rainbow of colors
" Plug 'ryanoasis/vim-devicons'             " Dev Icons
" Plug 'vim-airline/vim-airline'            " Very cool status line
" Plug 'vim-airline/vim-airline-themes'     " Very cool status line theme
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'feline-nvim/feline.nvim'            " Very cool status line
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/dashboard-nvim'
Plug 'levouh/tint.nvim'

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
" Plug 'APZelos/blamer.nvim'                " VS Code's GitLens
" Plug 'antoyo/vim-licenses'
Plug 'smbl64/vim-black-macchiato'         " partial formatter for python
Plug 'deton/jasegment.vim'
Plug 'IMOKURI/apyrori.nvim'               " python auto import

" --------------------
" Markdown 
" --------------------
Plug 'iamcco/markdown-preview.nvim', { 'tag': 'v0.0.10', 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
