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
" general
" --------------------

" --------------------
" code/project navigation
" --------------------
Plug 'liuchengxu/vista.vim'               " View and search LSP symbols, tags in Vim/NeoVim.

" --------------------
" Code/Project navigation
" --------------------
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plug 'tpope/vim-fugitive'                 " Git wrapper
Plug 'kassio/neoterm'
Plug 'ggandor/lightspeed.nvim'


" --------------------
" fuzzy finder
" --------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Plug 'Shougo/ddu.vim'
" Plug 'Shougo/ddu-ui-ff'
" Plug 'Shougo/ddu-source-file_rec'
" Plug 'Shougo/ddu-filter-matcher_substring'
" Plug 'Shougo/ddu-kind-file'


" --------------------
" Fancy appearance
" --------------------
Plug 'joshdick/onedark.vim'                 " I prefer this
Plug 'kien/rainbow_parentheses.vim'         " Highlights matching parenthesis with a rainbow of colors
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'freddiehaddad/feline.nvim'            " Very cool status line
Plug 'rebelot/heirline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'levouh/tint.nvim'

" --------------------
" Language support, auto completion
" --------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'jiangmiao/auto-pairs'               " pairs
Plug 'tpope/vim-surround'                 " surroundings
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'            " a simple, easy-to-use Vim alignment plugin.
Plug 'terryma/vim-multiple-cursors'       " multiple selection
Plug 'kamykn/spelunker.vim'               " spell check
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }  " auto completion of pydocstring
Plug 'chiphogg/vim-prototxt'              " syntax highlight for caffe prototxt files
Plug 'smbl64/vim-black-macchiato'         " partial formatter for python
Plug 'deton/jasegment.vim'
Plug 'IMOKURI/apyrori.nvim'               " python auto import

Plug 'github/copilot.vim'

" Copilot Chat
" Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
" Plug 'MunifTanjim/nui.nvim'  " plugin ui
" Plug 'amitds1997/remote-nvim.nvim'
" --------------------
" Markdown 
" --------------------
Plug 'iamcco/markdown-preview.nvim', { 'tag': 'v0.0.10', 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
