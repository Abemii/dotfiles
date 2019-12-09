function! Mdpdf() abort
  if expand('%:e') != 'md'
    return
  endif
  let l:command = 'mdpdf ' . expand('%:p')
  call system(l:command)
  call system('open ' . expand('%:r') . '.pdf')
endfunction

command! Mdpdf call Mdpdf()
