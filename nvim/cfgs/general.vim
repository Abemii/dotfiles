" ---------------------------
" Color Scheme
" ---------------------------
colorscheme onedark

" ---------------------------
" junegunn/fzf.vim
" ---------------------------
" use ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" fzf
nnoremap <silent> <leader>,f :Files<CR>
nnoremap <silent> <leader>,g :GFiles<CR>
nnoremap <silent> <leader>,G :GFiles?<CR>
nnoremap <silent> <leader>,b :Buffers<CR>
nnoremap <silent> <leader>,h :History<CR>
nnoremap <silent> <leader>,r :Rg<CR>
nnoremap <silent> <leader>,m :Marks<CR>
nnoremap <silent> <leader>,c :Colors<CR>

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

" " --------------------------
" " Airline settings
" " --------------------------
" let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#formatter='unique_tail_improved'
" let g:airline_powerline_fonts=1
" let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline_theme='bubblegum'
" let g:airline_section_c = airline#section#create(['file'])


" " -----------------------
" " DevIcon settings
" " -----------------------
" " loading the plugin 
" let g:webdevicons_enable = 1
" 
" " adding the flags to NERDTree 
" let g:webdevicons_enable_nerdtree = 1
" 
" " adding to vim-airline's tabline
" " let g:webdevicons_enable_airline_tabline = 1
" 
" " adding to vim-airline's statusline
" " let g:webdevicons_enable_airline_statusline = 1
" 
" " turn on/off file node glyph decorations (not particularly useful)
" let g:WebDevIconsUnicodeDecorateFileNodes = 1
" 
" " use double-width(1) or single-width(0) glyphs 
" " only manipulates padding, has no effect on terminal or set(guifont) font
" let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" 
" " whether or not to show the nerdtree brackets around flags 
" let g:webdevicons_conceal_nerdtree_brackets = 0
" 
" " the amount of space to use after the glyph character (default ' ')
" let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" 
" " Force extra padding in NERDTree so that the filetype icons line up vertically
" let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 
" 
" " change the default character when no match found
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
" 
" " set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" " disabled by default with no value
" let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''
" 
" " enable folder/directory glyph flag (disabled by default with 0)
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" 
" " enable open and close folder/directory glyph flags (disabled by default with 0)
" let g:DevIconsEnableFoldersOpenClose = 1
" 
" " enable pattern matching glyphs on folder/directory (enabled by default with 1)
" let g:DevIconsEnableFolderPatternMatching = 1
" 
" " enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
" let g:DevIconsEnableFolderExtensionPatternMatching = 0


" -----------------------
" NERDTree settings
" -----------------------
" let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
" let g:NERDTreeWinSize=35
" let g:NERDTreeChDirMode=2
" let g:NERDTreeHijackNetrw=0
" let g:NERDTreeCascadeOpenSingleChildDir=1
" autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
"
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " Automatically quit vim if NERDTree is last and only buffer
" let g:NERDTreeDirArrows = 1
" let g:NERDTreeDirArrowExpandable = '▶'
" let g:NERDTreeDirArrowCollapsible = '▼'
"
" let g:NERDTreeMinimalUI = 1
"
" let g:NERDTreeShowHidden = 1
"
" " nerdtree shortcut
"  nnoremap <silent> " :NERDTreeToggle<CR>


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
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Gclog<CR>
" nnoremap <leader>gb :Git blame<CR>


" ----------------------------
" APZelos/blamer.nvim
" ----------------------------
nnoremap <silent> <leader>gb :BlamerToggle<CR>
let g:blamer_enabled = 0
let g:blamer_delay = 500
let g:blamer_prefix = ' > '


" " ----------------------------
" " airblade/vim-gitgutter
" " ----------------------------
" nnoremap g[ :GitGutterPrevHunk<CR>
" nnoremap g] :GitGutterNextHunk<CR>
" nnoremap gh :GitGutterLineHighlightsToggle<CR>
" nnoremap gp :GitGutterPreviewHunk<CR>
" highlight GitGutterAdd ctermfg=green
" highlight GitGutterChange ctermfg=blue
" highlight GitGutterDelete ctermfg=red


" ----------------------------
" treesitter
" ----------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
