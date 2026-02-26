if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" open entry in a new vertical window
nnoremap <silent><expr><buffer> <c-v> &splitright ? "\<c-w>\<cr>\<c-w>L\<c-w>p\<c-w>J\<c-w>p" : "\<c-w>\<cr>\<c-w>H\<c-w>p\<c-w>J\<c-w>p"

" open entry in a new horizontal window
nnoremap <silent><expr><buffer> <c-s> &splitbelow ? "\<c-w>\<cr>\<c-w>p\<c-w>J\<c-w>p" : "\<c-w>\<cr>"

" open entry in a new tab
nnoremap <silent><buffer> <c-t> <c-w><cr><c-w>T

" open entry and return focus to quickfix/location list
nnoremap <silent><buffer> p <cr><c-w>p

" open entry and close the quickfix/location list window
let b:qf_isLoc = get(get(getwininfo(win_getid()), 0, {}), 'loclist', 0)
if b:qf_isLoc == 1
  nnoremap <silent><buffer> T <cr>:lclose<cr>
else
  nnoremap <silent><buffer> T <cr>:cclose<cr>
endif
