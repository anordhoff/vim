function comment#Comment(start, end)
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:start .. 'G'
endfunction

function comment#Duplicate(start, end)
  exec a:start .. ',' .. a:end .. 'copy ' .. a:end
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:end .. 'Gj'
endfunction

function comment#CommentRange(start, end)
  call comment#Comment(a:start, a:end)
  exec 'normal! 0'
endfunction

function comment#DuplicateLines(count)
  call comment#Duplicate(line('.'), line('.') + a:count - 1)
  silent! call repeat#set("gzz", a:count)
endfunction

function comment#DuplicateVisual(start, end)
  let start = line(a:start)
  let end = line(a:end)
  call comment#Duplicate(start, end)
  silent! call repeat#set("gzz", end - start + 1)
endfunction

function comment#DuplicateOperator(type)
  call comment#Duplicate(line("'["), line("']"))
  exec 'normal! 0'
endfunction

function comment#DuplicateRange(start, end)
  call comment#Duplicate(a:start, a:end)
  exec 'normal! 0'
endfunction
