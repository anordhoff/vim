" operatorfunc wrapper for duplicate#Duplicate
function duplicate#DuplicateOp(type)
  call duplicate#Duplicate(line("'["), line("']"))
endfunction

" duplicate a range of lines
function duplicate#Duplicate(start, end)
  exec a:start .. ',' .. a:end .. 'copy ' .. a:end
  exec a:start .. ',' .. a:end .. 'Commentary'
  exec 'normal! ' .. a:end .. 'Gj'
  silent! call repeat#set("gzz", a:end - a:start + 1)
endfunction
