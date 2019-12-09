"------------------------
" NERDTree settings
" -----------------------
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let g:NERDTreeWinSize=25
let g:NERDTreeChDirMode=2
let g:NERDTreeHijackNetrw=0
let g:NERDTreeCascadeOpenSingleChildDir=1
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " Automatically quit vim if NERDTree is last and only buffer
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

let g:NERDTreeMinimalUI = 1

let g:NERDTreeShowHidden = 1

" nerdtree shortcut
nnoremap " :NERDTreeToggle<CR>


