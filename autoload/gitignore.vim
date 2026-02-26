function gitignore#WildignoreList(filename)
  if !filereadable(a:filename)
    return ''
  endif

  let ignorestring = ''
  for oline in readfile(a:filename)
    let line = substitute(oline, '\s|\n|\r', '', "g")
    let line = substitute(line, ',', '\\\\,', "g")
    if line =~ '^#' | con | endif
    if line == ''   | con | endif
    if line =~ '^!' | con | endif
    if line =~ '/$' | let ignorestring .= "," . line . "*" | con | endif
    let ignorestring .= "," . substitute(line, ' ', '\\ ', "g")
  endfor
  return ',' .. substitute(ignorestring, '^,', '', "g")
endfunction
