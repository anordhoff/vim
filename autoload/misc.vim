function misc#Clear(chars)
  for char in split(a:chars, '\zs')
    call setreg(char, [])
  endfor
  echo "Successfully cleared registers '" .. a:chars ..
    \ "'. Execute :wviminfo! to persist changes"
endfunction

function misc#SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function misc#RestoreCursor()
  if &ft =~# 'commit\|rebase'
    return
  endif
  if line("'\"") > 1 && line("'\"") <= line("$")
    exec 'normal! g`"zz'
  endif
endfunction
