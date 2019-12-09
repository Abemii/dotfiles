" -----------------------
" TagBar
" -----------------------
let g:tagbar_autofocus=0
let g:tagbar_width=25
" Always open TagBar when open python files. I don't like it much so let's
" comment it.
" autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose
nmap <F8> :TagbarToggle<CR>


" -----------------------
" Vim-tags
" -----------------------
au BufNewFile,BufRead *.py let g:vim_tags_project_tags_command = "ctags --languages=python --extra=+f `pwd` 2>/dev/null &"
