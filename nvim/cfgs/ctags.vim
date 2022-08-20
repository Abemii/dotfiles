" " -----------------------
" " TagBar
" " -----------------------
" let g:tagbar_autofocus=0
" let g:tagbar_width=25
" " Always open TagBar when open python files. I don't like it much so let's
" " comment it.
" " autocmd BufEnter *.py :call tagbar#autoopen(0)
" autocmd BufWinLeave *.py :TagbarClose
" nnoremap <F8> :TagbarToggle<CR>
" 
" let g:tagbar_map_togglesort = "r"
" 
" " -----------------------
" " Vim-tags
" " -----------------------
" au BufNewFile,BufRead *.py let g:vim_tags_project_tags_command = "ctags --languages=python --extra=+f `pwd` 2>/dev/null &"
" 
" set tags=.tags;~
" 
" function! s:execute_ctags() abort
"   " 探すタグファイル名
"   let tag_name = '.tags'
"   " ディレクトリを遡り、タグファイルを探し、パス取得
"   let tags_path = findfile(tag_name, '.;')
"   " タグファイルパスが見つからなかった場合
"   if tags_path ==# ''
"     return
"   endif
" 
"   " タグファイルのディレクトリパスを取得
"   " `:p:h`の部分は、:h filename-modifiersで確認
"   let tags_dirpath = fnamemodify(tags_path, ':p:h')
"   " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
"   execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
" endfunction
" 
" augroup ctags
"   autocmd!
"   autocmd BufWritePost * call s:execute_ctags()
" augroup END
" 
" " Add support for markdown files in tagbar.
" let g:tagbar_type_markdown = {
"     \ 'ctagstype': 'markdown',
"     \ 'ctagsbin' : $HOME . '/.config/nvim/plugged/markdown2ctags/markdown2ctags.py',
"     \ 'ctagsargs' : '-f - --sort=yes --sro=»',
"     \ 'kinds' : [
"         \ 's:sections',
"         \ 'i:images'
"     \ ],
"     \ 'sro' : '»',
"     \ 'kind2scope' : {
"         \ 's' : 'section',
"     \ },
"     \ 'sort': 0,
" \ }

" " -----------------------
" " Vista
" " -----------------------
" 
" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" 
" set statusline+=%{NearestMethodOrFunction()}
" 
" " By default vista.vim never run if you don't call it explicitly.
" "
" " If you want to show the nearest function in your statusline automatically,
" " you can add the following line to your vimrc
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" 
" " MIT License. Copyright (c) 2021 s1341 (github@shmarya.net)
" " Plugin: https://github.com/liuchengxu/vista.vim
" " vim: et ts=2 sts=2 sw=2
" 
" scriptencoding utf-8
" if !get(g:, 'loaded_vista', 0)
"   finish
" endif
" 
" function! airline#extensions#vista#currenttag() abort
"   if get(w:, 'airline_active', 0)
"     return airline#util#shorten(get(b:, 'vista_nearest_method_or_function', ''), 91, 9)
"   endif
" endfunction
" 
" function! airline#extensions#vista#init(ext) abort
"   call airline#parts#define_function('vista', 'airline#extensions#vista#currenttag')
" endfunction
" 
" 
" " Settings from readme.md
" 
" " How each level is indented and what to prepend.
" " This could make the display more compact or more spacious.
" " e.g., more compact: ["▸ ", ""]
" " Note: this option only works for the kind renderer, not the tree renderer.
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" 
" " Executive used when opening vista sidebar without specifying it.
" " See all the avaliable executives via `:echo g:vista#executives`.
" let g:vista_default_executive = 'coc'
" 
" " To enable fzf's preview window set g:vista_fzf_preview.
" " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" " For example:
" let g:vista_fzf_preview = ['right:50%']
" 
" " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
" let g:vista#renderer#enable_icon = 1
" 
" " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
" 
" nmap <silent> <C-f><C-v> :<C-u>Vista coc<CR>
" nmap <silent> <C-f><C-s> :<C-u>Vista finder coc<CR>
