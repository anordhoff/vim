nnoremap <silent> gzz :<c-u>call duplicate#Duplicate(line('.'), line('.') + v:count1 - 1)<cr>
nnoremap <silent> gz :set opfunc=duplicate#DuplicateOp<cr>g@
xnoremap <silent> gz :<c-u>call duplicate#Duplicate(line("'<"), line("'>"))<cr>
