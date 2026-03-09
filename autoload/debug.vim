" spawn a delve terminal in verbose mode
function debug#Delve(file)
  let g:test#go#runner = 'delve'
  let g:test#transformation = 'delve'

  if a:file
    TestFile -strategy=spawn
  else
    TestNearest -strategy=spawn
  endif

  unlet g:test#transformation
  unlet g:test#go#runner
endfunction
