
" Python Quickrun
let g:quickrun_config = {
    \ '_' : {
        \ 'runner' : 'vimproc',
        \ 'runner/vimproc/updatetime' : 40,
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split' : ':botright 8sp',
    \ },
    \ 'tex' : {
        \ 'command' : 'latexmk',
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'null',
        \ 'outputter/error/error' : 'quickfix',
        \ 'srcfile' : expand("%"),
        \ 'cmdopt': '-pdfdvi',
        \ 'hook/sweep/files' : [
        \                      '%S:p:r.aux',
        \                      '%S:p:r.bbl',
        \                      '%S:p:r.blg',
        \                      '%S:p:r.dvi',
        \                      '%S:p:r.fdb_latexmk',
        \                      '%S:p:r.fls',
        \                      '%S:p:r.log',
        \                      '%S:p:r.out'
        \                      ],
        \ 'exec': '%c %o %a %s',
    \ },
    \ 'cpp' : {
        \ 'command': 'g++',
        \ 'input': 'input',
        \ 'runner': 'system'
    \ },
    \ 'python' : {
        \ 'command': 'python',
        \ 'cmdopt': '-u'
    \ }
\}

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>e :cclose<CR>:write<CR>:QuickRun -mode n<CR>

