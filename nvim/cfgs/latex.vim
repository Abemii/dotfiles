" LaTeX
autocmd BufNewFile,BufRead *.tex,*.sty,*.cls
    \ set filetype=tex |
    \ set shiftwidth=2 |
    \ set tabstop=2
autocmd BufNewFile,BufRead *.bib
    \ set shiftwidth=2 |
    \ set tabstop=2
autocmd FileType tex
    \ setlocal spell spelllang=en_us,cjk |
    \ let b:autoformat_autoindent=0
" Disable folding by environment unit
"let g:vimtex_fold_envs = 0
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
" Disable the conceal function
let g:tex_conceal = ''
let g:vimtex_compiler_latexmk = {
    \ 'backend': has('nvim') ? 'nvim' : 'jobs',
    \ 'background': 1,
    \ 'build_dir': '',
    \ 'callback': 0,
    \ 'continuous': 1,
    \ 'executable': 'latexmk',
    \ 'options': [
    \   '-pdfdvi',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" vim-latex-live-viewer config
let g:livepreview_previewer = 'open -a Skim'
let g:livepreview_engine = 'latexmk'

autocmd BufWritePost,FileWritePost *.tex QuickRun tex
