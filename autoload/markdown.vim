" auto-increment numbered list items when pressing enter
function markdown#IncrementList()
  let line = getline('.')
  let match = matchlist(line, '^\(\s*\)\(\d\+\)\.\s')
  if !empty(match)
    let indent = match[1]
    let num = str2nr(match[2]) + 1
    " if the line only has the number and no content, remove it
    if line =~ '^\s*\d\+\.\s*$'
      call setline('.', '')
      return "\<cr>"
    endif
    return "\<cr>" .. indent .. num .. ". "
  endif
  return "\<cr>"
endfunction

" operatorfunc wrapper for markdown#Renumber
function markdown#RenumberOp(type)
  call markdown#Renumber(line("'["), line("']"))
endfunction

" renumber a range of numbered list items sequentially
function markdown#Renumber(start, end)
  let lnum = a:start
  let num = 0
  while lnum <= a:end
    let line = getline(lnum)
    let match = matchlist(line, '^\(\s*\)\(\d\+\)\.\(\s.*\)$')
    if !empty(match)
      if num == 0
        let num = str2nr(match[2])
      endif
      call setline(lnum, match[1] .. num .. '.' .. match[3])
      let num += 1
    else
      let num = 0
    endif
    let lnum += 1
  endwhile
endfunction
