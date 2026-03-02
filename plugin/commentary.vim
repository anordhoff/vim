nmap <silent> gzz :<c-u>call duplicate#Duplicate(line('.'), line('.') + v:count1 - 1)<cr>
nmap <silent> gz :set opfunc=duplicate#DuplicateOp<cr>g@
xmap <silent> gz :<c-u>call duplicate#Duplicate(line("'<"), line("'>"))<cr>
