" Markdown
" Render key bindings
autocmd BufNewFile,BufRead *.md
    \ set filetype=markdown |
    \ nmap <silent> <F9> <Plug>MarkdownPreview |
    \ imap <silent> <F9> <Plug>MarkdownPreview |
    \ nmap <silent> <F10> <Plug>StopMarkdownPreview |
    \ imap <silent> <F10> <Plug>StopMarkdownPreview

" Disable imperfect syntax highlight
autocmd FileType markdown
    \ hi def link markdownItalic              NONE |
    \ hi def link markdownItalicDelimiter     NONE |
    \ hi def link markdownBold                NONE |
    \ hi def link markdownBoldDelimiter       NONE |
    \ hi def link markdownBoldItalic          NONE |
    \ hi def link markdownBoldItalicDelimiter NONE
" Update preview only when saving, exiting insert mode
let g:mkdp_refresh_slow = 1
let g:mkdp_path_to_chrome = "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
