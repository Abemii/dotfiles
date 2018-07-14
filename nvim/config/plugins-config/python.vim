
" -----------------------
" Neomake settings
" -----------------------
call neomake#configure#automake('w')
let g:neomake_open_list=2

" -----------------------
" Deoplete settings
" -----------------------
let g:deoplete#enable_at_startup=1

" -----------------------
" Search settings
" -----------------------
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

" ---------------------------
" Comfortable Motion settings
" ---------------------------
let g:comfortable_motion_scroll_down_key="j"
let g:comfortable_motion_scroll_up_key="k"
let g:comfortable_motion_no_default_key_mappings=1
let g:comfortable_motion_impulse_multiplier=25  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

" --------------------------
" Airline settings - uncomment if you want to use vim-airline over lightline
" --------------------------
" let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#formatter='unique_tail'
" let g:airline_powerline_fonts=1
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#tabline#enabled = 1

" --------------------
" Lightline settings
" ---------------------
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
    \  },
    \  'component': {
    \     'lineinfo': ' %3l:%-2v',
    \  },
    \  'component_function': {
    \     'gitbranch': 'gitbranch#name'
    \  }
    \ }
let g:lightline.colorscheme = 'one'

"------------------------
" NERDTree settings
" -----------------------
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let g:NERDTreeHijackNetrw=0
let NERDTreeCascadeOpenSingleChildDir=1
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>

" -----------------------
" TagBar
" -----------------------
let g:tagbar_autofocus=0
let g:tagbar_width=42
" Always open TagBar when open python files. I don't like it much so let's
" comment it.
" autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose
nmap <F8> :TagbarToggle<CR>

" -----------------------
" NERDComment settings
" -----------------------

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" -----------------------
" DevIcon settings
" -----------------------
" loading the plugin 
let g:webdevicons_enable = 1

" adding the flags to NERDTree 
let g:webdevicons_enable_nerdtree = 1

" adding to vim-airline's tabline
" let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
" let g:webdevicons_enable_airline_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs 
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags 
let g:webdevicons_conceal_nerdtree_brackets = 0

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 

" change the default character when no match found
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" disabled by default with no value
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 0

" -----------------------
" SnipMate settings
" -----------------------
let g:snippets_dir='~/.config/nvim/plugged/vim-snippets/snippets/'

" ----------------------------
" Rainbow Parentheses Autoload
" ----------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ------------------------
" CtrlSpace - Fuzzy search
" ------------------------
if has("gui_running")
    let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
endif

" Require install silversearcher-ag
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
" Colors
hi link CtrlSpaceNormal   PMenu
hi link CtrlSpaceSelected PMenuSel
hi link CtrlSpaceSearch   Search
hi link CtrlSpaceStatus   StatusLine
hi link CtrlSpaceSearch IncSearch
" We need this line to work around with neovim: https://github.com/vim-ctrlspace/vim-ctrlspace/issues/188<Paste>
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
" Fuzzy Search
nnoremap <silent><C-p> :CtrlSpace O<CR>
" Automatically Saving Workspace
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1

" -----------------------
" Python
" -----------------------

" python executables for different plugins
let g:pymode_python='python'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=8
augroup END

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'
let g:ale_sign_column_always=0
let g:ale_emit_conflict_warnings=0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0

imap <F5> <Esc>:w<CR>:!clear;python %<CR>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
