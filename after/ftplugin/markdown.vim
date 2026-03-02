setlocal wrap
setlocal showbreak=NONE
setlocal formatoptions+=ro
setlocal formatoptions-=t

" automatically continue lists when creating a newline
setlocal comments-=fb:- comments+=b:-
setlocal comments-=fb:* comments+=b:*

" auto-increment numbered list items
inoremap <buffer><expr> <cr> markdown#IncrementList()

" correct numbered list numbers using gq
nnoremap <buffer><silent> gq :set opfunc=<SID>RenumberOp<cr>g@
xnoremap <buffer><silent> gq :<c-u>call markdown#Renumber(line("'<"), line("'>"))<cr>
function s:RenumberOp(type)
  call markdown#Renumber(line("'["), line("']"))
endfunction
