let test#strategy = "dispatch"
let test#go#gotest#options = '-fullpath -coverprofile=coverage.out'
let g:test#runner_commands = ['GoTest', 'Delve']

" transformation that enables verbose logging for delve
function s:DelveTransformVerbose(cmd) abort
  if a:cmd =~ '--'
    return a:cmd .. ' -test.v'
  else
    return a:cmd .. ' -- -test.v'
  endif
endfunction
let g:test#custom_transformations = {'delve': function('s:DelveTransformVerbose')}

" testing keymaps
nnoremap <silent> <leader>tt :TestNearest<cr>
nnoremap <silent> <leader>tv :TestNearest -v<cr>
nnoremap <silent> <leader>T  :TestFile<cr>
nnoremap <silent> <leader>tc :TestClass<cr>
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tg :TestVisit<cr>
