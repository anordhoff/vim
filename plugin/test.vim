let test#strategy = "dispatch"
let test#go#gotest#options = '-fullpath -coverprofile=coverage.out'
let g:test#runner_commands = ['GoTest', 'Delve']

" transformation that enables verbose logging for delve
function! DelveTransformVerbose(cmd) abort
  if a:cmd =~ '--'
    return a:cmd .. ' -test.v'
  else
    return a:cmd .. ' -- -test.v'
  endif
endfunction
let g:test#custom_transformations = {'delve': function('DelveTransformVerbose')}

" keymaps
nnoremap <silent> <leader>t :TestNearest<cr>
nnoremap <silent> <leader>T :TestNearest -v<cr>
nnoremap <silent> <leader>l :TestLast<cr>
nnoremap <silent> <leader>p :TestFile<cr>

augroup test_config
  autocmd!

  " debugging keymaps
  autocmd Filetype go nnoremap <silent> z<cr> :call DebugNearest('delve')<cr>
  autocmd Filetype go nnoremap <silent> Z<cr> :call DebugFile('delve')<cr>

  " coverage commands
  autocmd Filetype go command! Cover :silent !go tool cover -html=coverage.out
  autocmd Filetype go command! Coverfunc :tabedit /tmp/coverage.func | setlocal noreadonly | :%d | execute 'read !go tool cover -func=coverage.out' | :1d | :silent write | setlocal readonly
augroup END

" spawn a debugging terminal session in verbose mode on the nearest test
function! DebugNearest(runner)
  let g:test#go#runner = a:runner
  let g:test#transformation = a:runner
  TestNearest -strategy=spawn
  unlet g:test#transformation
  unlet g:test#go#runner
endfunction

" spawn a debugging terminal session in verbose mode on the current test file/package
function! DebugFile(runner)
  let g:test#go#runner = a:runner
  let g:test#transformation = a:runner
  TestFile -strategy=spawn
  unlet g:test#transformation
  unlet g:test#go#runner
endfunction
