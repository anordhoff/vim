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
nnoremap <buffer><silent> p     :<c-u>let l=line('.')<cr>:exec 'aboveleft pedit +' . get(getqflist()[l - 1], 'lnum', 1) . ' ' . bufname(get(getqflist()[l - 1], 'bufnr', 0))<cr>:exec l<cr>
nmap     <buffer><silent> <c-n> jp
nmap     <buffer><silent> <c-p> kp
