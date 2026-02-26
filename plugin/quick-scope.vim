" enable, disable, or toggle quick-scope
nnoremap [oq :let g:qs_enable=1<cr>
nnoremap ]oq :let g:qs_enable=0<cr>
nnoremap <expr> yoq g:qs_enable ? ':let g:qs_enable=0<cr>' : ':let g:qs_enable=1<cr>'

" disable quick-scope for certain filetypes
let g:qs_filetype_blacklist = ['dispatch', 'help', 'qf', 'startuptime']
