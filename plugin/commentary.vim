" helper function for duplicate commands
function s:Duplicate(start, end)
  exec a:start .. ',' .. a:end .. 'copy ' .. a:end
  exec a:start .. ',' .. a:end .. 'Commentary'
  exec 'normal! ' .. a:end .. 'Gj'
endfunction

" duplicate a count of lines
nmap <silent> gzz :<c-u>call <SID>DuplicateLines(v:count1)<cr>
function s:DuplicateLines(count)
  call s:Duplicate(line('.'), line('.') + a:count - 1)
  silent! call repeat#set("gzz", a:count)
endfunction

" duplicate the highlighted lines
xmap <silent> gz :<c-u>call <SID>DuplicateVisual("'<", "'>")<cr>
function s:DuplicateVisual(start, end)
  let l:start = line(a:start)
  let l:end = line(a:end)
  call s:Duplicate(l:start, l:end)
  silent! call repeat#set("gzz", l:end - l:start + 1)
endfunction

" duplicate lines that a motion moves over
nmap <silent> gz :set opfunc=<SID>DuplicateOperator<cr>g@
function s:DuplicateOperator(type)
  call s:Duplicate(line("'["), line("']"))
  exec 'normal! 0'
endfunction
