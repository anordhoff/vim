" extend vim-husk such that ctrl-y and ctrl-w mimic bash
cnoremap <expr> <c-y> pumvisible() ? "\<c-y>" : "\<c-r>\""
cnoremap <c-w> <cmd>let g:iskeyword=&iskeyword<bar>
  \ set iskeyword=
  \ <cr><c-w><cmd>
  \ let &iskeyword=g:iskeyword<bar>
  \ unlet g:iskeyword<cr>
