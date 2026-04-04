" enable, disable, or toggle quick-scope
nnoremap [oq <cmd>let g:qs_enable=1 <bar> echo 'let g:qs_enable=1'<cr>
nnoremap ]oq <cmd>let g:qs_enable=0 <bar> echo 'let g:qs_enable=0'<cr>
nnoremap <expr> yoq g:qs_enable ?
  \ "<cmd>let g:qs_enable=0 <bar> echo 'let g:qs_enable=0'<cr>" :
  \ "<cmd>let g:qs_enable=1 <bar> echo 'let g:qs_enable=1'<cr>"

" disable quick-scope for certain filetypes
let g:qs_filetype_blacklist = ['dispatch', 'help', 'qf', 'startuptime']

" search highlights are not overridden by quickscope highlights
let g:qs_hi_priority = -1
