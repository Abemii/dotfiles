" " lint
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 1
" let g:ale_linters = {'python': ['flake8']}
" " fix
" let g:ale_fix_on_save = 0
" let g:ale_fixers = {
"   \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"   \   'python': ['black', 'isort'],
"   \ }
" let g:ale_python_flake8_executable = g:python3_host_prog
" let g:ale_python_flake8_options = '-m flake8'
" let g:ale_python_black_executable = g:python3_host_prog
" let g:ale_python_black_options = '-m black'
" let g:ale_python_isort_executable = g:python3_host_prog
" let g:ale_python_isort_options = '-m isort'
" nmap <silent> <Leader>x <plug>(ale_fix)
" 
" " appearance
" let g:ale_sign_column_always = 1
" let g:ale_set_highlights = 0
" let g:ale_sign_error = '!!'
" let g:ale_sign_warning = '=='
" let g:ale_echo_msg_format = '[%linter%] %s'
" let g:ale_completion_enabled = 0
" let g:ale_emit_conflict_warnings=0
" let g:ale_statusline_format = ['E%d', 'W%d', '']
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 1
