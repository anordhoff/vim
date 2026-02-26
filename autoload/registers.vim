function registers#Clear(chars)
  for char in split(a:chars, '\zs')
    call setreg(char, [])
  endfor
  echo "Successfully cleared registers '" .. a:chars ..
    \ "'. Execute :wshada! to persist changes"
endfunction
