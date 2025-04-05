" Comment codes
autocmd FileType python,shell set commentstring=#\ %s

" -----------------------
" EasyAlign settings
" -----------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -----------------------
" NERDComment settings
" -----------------------

let g:NERDSpaceDelims=1                      " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1                " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'              " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1                 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = {
    \ 'c': { 'left': '/**','right': '*/' },
    \ 'prototxt': { 'left': '#' },
    \ }                                      " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1              " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1         " Enable trimming of trailing whitespace when uncommenting


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
