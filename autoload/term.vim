let g:termbuf = get(g:, 'termbuf', 0)
let g:termwin = get(g:, 'termwin', 0)

" toggle a horizontal/vertical terminal split
function term#Toggle(vsplit)

  " if a terminal window exists in another tab, print an error
  if bufwinid(g:termbuf) == -1 && win_findbuf(g:termbuf) != []
    echohl ErrorMsg | echo 'Terminal already open in another tab' | echohl None
    return
  endif

  " if a terminal window is open, hide it; else, open the terminal window
  if getbufvar(winbufnr(g:termwin), '&buftype') == 'terminal'
    if winnr('$') == 1
      echohl ErrorMsg | echo 'Terminal is only window in current tab' | echohl None
      return
    endif
    if win_gotoid(g:termwin)
      hide
      wincmd p
    endif
  else
    try
      if a:vsplit
        exec 'botright vertical sbuffer ' .. g:termbuf
      else
        exec 'botright sbuffer ' .. g:termbuf
      endif
      let g:termwin = win_getid()
    catch
      echohl ErrorMsg | echo 'Terminal does not exist' | echohl None
    endtry
  endif
endfunction
