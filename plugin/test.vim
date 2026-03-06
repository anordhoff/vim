let test#strategy = "dispatch"
let test#go#gotest#options = '-fullpath -coverprofile=coverage.out'
let g:test#runner_commands = ['GoTest', 'Delve']

" transformation that enables verbose logging for delve
function DelveTransformVerbose(cmd) abort
  if a:cmd =~ '--'
    return a:cmd .. ' -test.v'
  else
    return a:cmd .. ' -- -test.v'
  endif
endfunction
let g:test#custom_transformations = {'delve': function('DelveTransformVerbose')}

" keymaps
nnoremap <silent> <leader>tt :TestNearest<cr>
nnoremap <silent> <leader>tv :TestNearest -v<cr>
nnoremap <silent> <leader>tc :TestClass<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tg :TestVisit<cr>

" delve keymaps
augroup test_config
  autocmd!
  autocmd Filetype go nnoremap <silent> z<cr> :call Debug('delve', false)<cr>
  autocmd Filetype go nnoremap <silent> Z<cr> :call Debug('delve', true)<cr>
augroup END

" spawn a delve terminal in verbose mode
function Debug(runner, file)
  let g:test#go#runner = a:runner
  let g:test#transformation = a:runner

  if a:file
    TestFile -strategy=spawn
  else
    TestNearest -strategy=spawn
  endif

  unlet g:test#transformation
  unlet g:test#go#runner
endfunction
