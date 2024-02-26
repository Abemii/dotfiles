" ---------------------------
" Color Scheme
" ---------------------------
colorscheme onedark

" ---------------------------
" nvim-telescope/telescope.nvim
" ---------------------------
nnoremap <silent> <leader>,f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <leader>,g <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <silent> <leader>,b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>,h <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <silent> <leader>,r <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <leader>,m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <silent> <leader>,c <cmd>lua require('telescope.builtin').colorscheme()<cr>

" Comment codes
autocmd FileType python,shell set commentstring=#\ %s

" ---------------------------
" Comfortable Motion settings
" ---------------------------
let g:comfortable_motion_scroll_down_key="j"
let g:comfortable_motion_scroll_up_key="k"
let g:comfortable_motion_no_default_key_mappings=1
let g:comfortable_motion_impulse_multiplier=1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>

" --------------------
" Fern settings
" --------------------
nnoremap <silent> " :Fern . -reveal=% -drawer -toggle -width=35<CR>
let g:fern#renderer = 'nerdfont'
let g:fern#default_exclude = '__pycache__'
augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

function! s:init_fern() abort
    " Define NERDTree like mappings
    nmap <buffer> o <Plug>(fern-action-open:edit)
    nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
    nmap <buffer> t <Plug>(fern-action-open:tabedit)
    nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
    nmap <buffer> i <Plug>(fern-action-open:split)
    nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
    nmap <buffer> s <Plug>(fern-action-open:vsplit)
    nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
    nmap <buffer> ma <Plug>(fern-action-new-path)

    nmap <buffer> C <Plug>(fern-action-enter)
    nmap <buffer> u <Plug>(fern-action-leave)
    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
    nmap <buffer> cd <Plug>(fern-action-cd)
    nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

    nmap <buffer> q :<C-u>quit<CR>
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

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
" Rainbow Parentheses Autoload
" ----------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" ----------------------------
" kassio/neoterm
" ----------------------------
let g:neoterm_default_mod='belowright'
let g:neoterm_size=10
let g:neoterm_autoscroll=1
let g:neoterm_fixedsize=1
tnoremap <silent> <C-w> <C-\><C-n><C-w>
nnoremap <silent> <C-n> :TREPLSendLine<CR>j0
vnoremap <silent> <C-n> V:TREPLSendSelection<CR>'>j0

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
" tpope/vim-fugitive
" ----------------------------
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Git commit<CR><CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gl :Gclog<CR>
" nnoremap <leader>gb :Git blame<CR>


" ----------------------------
" treesitter
" ----------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim","dockerfile","json","lua","gitignore","bash","markdown","css","yaml","toml","vue","html","cpp","python","diff","java","jq","latex","make"},
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
