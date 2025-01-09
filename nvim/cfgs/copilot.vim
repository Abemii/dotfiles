imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
imap <silent> <M-i> <Plug>(copilot-next)
imap <silent> <M-o> <Plug>(copilot-previous)


" lua << EOF
" require("CopilotChat").setup {
"   debug = true, -- Enable debugging
"   -- See Configuration section for rest
" }
" EOF
