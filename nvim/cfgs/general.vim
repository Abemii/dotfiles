" Comment codes
autocmd FileType python,shell set commentstring=#\ %s

" ----------------------------
" heavenshell/vim-pydocstring
" ----------------------------
" keymap
nmap <silent> <C-_> <Plug>(pydocstring)
" formatter
let g:pydocstring_formatter = 'google'


" ----------------------------
" Zoom / Restore window.
" ----------------------------
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader><leader> :ZoomToggle<CR>


" ----------------------------
" custom functions
" ----------------------------

function! s:modifiable_windo(cmd)
  windo if &modifiable | execute a:cmd | endif
endfunction

command! -nargs=1 ModWindo call s:modifiable_windo(<q-args>)
