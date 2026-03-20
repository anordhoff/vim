if exists('b:did_custom_ftplugin')
  finish
endif
let b:did_custom_ftplugin = 1

" open entry in a new horizontal window
nnoremap <silent><expr><buffer> <c-s> &splitbelow ? "\<c-w>\<cr>\<c-w>p\<c-w>J\<c-w>p" : "\<c-w>\<cr>"

" open entry in a new vertical window
nnoremap <silent><expr><buffer> <c-v> &splitright ? "\<c-w>\<cr>\<c-w>L\<c-w>p\<c-w>J\<c-w>p" : "\<c-w>\<cr>\<c-w>H\<c-w>p\<c-w>J\<c-w>p"

" open entry in a new tab
nnoremap <silent><buffer> <c-t> <c-w><cr><c-w>T

" open entry in a preview window
nnoremap <silent><buffer> p <cmd>call quickfix#Preview()<cr>
nmap     <silent><buffer> <c-n> jp
nmap     <silent><buffer> <c-p> kp
