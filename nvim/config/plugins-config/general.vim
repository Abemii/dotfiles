"----------- Plugin settings ----------
" Color Scheme
colorscheme onehalfdark

" Completion
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
let g:completor_html_omni_trigger = '<?[a-z].*$'
let g:completor_php_omni_trigger = '([$\w]+|use\s*|->[$\w]*|::[$\w]*|implements\s*|extends\s*|class\s+[$\w]+|new\s*)$'
let g:completor_tex_omni_trigger = '\\[A-Za-z]*'


" Fuzzy finder
" use ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Comment codes
autocmd FileType python,shell set commentstring=#\ %s

" Nerdtree
" open nerdtree when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open nerdtree when vim start up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
" nerdtree shortcut
nmap <F7> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>



" syntastic
let g:syntastic_python_checkers = ['pydocstyle', 'pycodestyle', 'pyflakes']

"  jedi setting
" Disable AutoComplPop
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
autocmd FileType pytthon setlocal completeopt-=preview

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

" deoplete-jedi settings
" let g:python3_host_prog = ''

syntax enable                             " enable syntaax highlighting

