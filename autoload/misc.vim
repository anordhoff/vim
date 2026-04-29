function misc#Grep(...)
  let output = system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
  if v:shell_error
    echohl ErrorMsg | echo 'E480: No match: ' .. join(a:000, ' ') | echohl None
  endif
  return output
endfunction

function misc#Search(forward) abort
  let chunks = getregion(getpos('.'), getpos('v'), #{type: mode()})
  call map(chunks, {_, v -> escape(v, '\')})
  let pat = '\V' .. join(chunks, '\n')
  call setreg('/', pat)
  call histadd('/', pat)
  let v:searchforward = a:forward
  return "\<Esc>" .. v:count1 .. 'n'
endfunction

function misc#Clear(chars)
  for char in split(a:chars, '\zs')
    call setreg(char, [])
  endfor
  echo "Successfully cleared registers '" .. a:chars ..
    \ "'. Execute :wviminfo! to persist changes"
endfunction

function misc#RestoreCursor()
  if &ft =~# 'commit\|rebase'
    return
  endif
  if line("'\"") > 1 && line("'\"") <= line("$")
    exec 'normal! g`"zz'
  endif
endfunction

function misc#Preview(...)
  let file =""
  if a:0 == 1
    let file = a:1
  else
    let file = expand('%')
  endif
  exec 'Start! grip -b ' .. file
endfunction
