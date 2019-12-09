
" -----------------------
" Jedi settings
" -----------------------
let g:jedi#popup_on_dot = 0  " Disable AutoComplPop
let g:jedi#popup_select_first = 0
autocmd FileType python setlocal completeopt-=preview

" -----------------------
" Deoplete settings
" -----------------------
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

" -----------------------
" NERDComment settings
" -----------------------

let g:NERDSpaceDelims=1                      " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1                " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'              " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1                 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = {
    \ 'c': { 'left': '/**','right': '*/' }, 
    \ }                                      " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1              " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1         " Enable trimming of trailing whitespace when uncommenting

" -----------------------
" SnipMate settings
" -----------------------
let g:snippets_dir=$HOME.'/.config/nvim/plugged/vim-snippets/snippets/'

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
let g:pymode_python='python3'

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
    " autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" code running
" let g:pymode_run=1
" let g:pymode_run_bind='<F5>'
" let g:pymode_rope_lookup_project = 0
" let g:pymode_rope = 0

" Linting (ale)
let g:ale_sign_column_always = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_echo_msg_format = '%s [%linter%]'
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'latex': ['chktex', 'lacheck'],
    \ }
let g:ale_fix_on_save = 0
let g:ale_fixers = {
    \ 'python': ['autopep8', 'isort'],
    \ }
let g:ale_python_pylint_options = '--max-line-length=120'
" let g:ale_python_flake8_executable = g:python3_host_prog
" let g:ale_python_flake8_options = '-m flake8'
" let g:ale_python_flake8_args = '--max-line-length=120'
" let g:ale_pyhton_autopep8_executable = g:python3_host_prog
" let g:ale_python_autopep8_options = '-m autopep8'
" let g:ale_python_isort_executable = g:python3_host_prog
" let g:ale_pythn_isort_options = '-m isort'
let g:ale_emit_conflict_warnings=0
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1


imap <F5> <Esc>:w<CR>:!clear;python %<CR>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

