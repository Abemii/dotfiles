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


" --------------------
" fuzzy finder
" --------------------
" Plug 'Shougo/ddu.vim'
" Plug 'Shougo/ddu-ui-ff'
" Plug 'Shougo/ddu-source-file_rec'
" Plug 'Shougo/ddu-filter-matcher_substring'
" Plug 'Shougo/ddu-kind-file'


Plug 'rebelot/heirline.nvim'
" --------------------
" Language support, auto completion
" --------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'       " multiple selection
Plug 'chiphogg/vim-prototxt'              " syntax highlight for caffe prototxt files
Plug 'IMOKURI/apyrori.nvim'               " python auto import

Plug 'github/copilot.vim'

" Copilot Chat
" Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
" Plug 'MunifTanjim/nui.nvim'  " plugin ui
" Plug 'amitds1997/remote-nvim.nvim'

call plug#end()
