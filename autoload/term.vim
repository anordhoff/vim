" toggle a horizontal/vertical terminal split
function term#Toggle(vsplit)
  if !exists('g:termbuf')
    let g:termbuf = 0
  endif
  if !exists('g:termwin')
    let g:termwin = 0
  endif

  " if a terminal window exists in another tab, print an error
  if bufwinid(g:termbuf) == -1 && win_findbuf(g:termbuf) != []
    echohl ErrorMsg | echo 'Terminal already open in another tab' | echohl None
    return
  endif

  " if a terminal window is open, hide it; else, (re)open a terminal window
  if getbufvar(winbufnr(g:termwin), '&buftype') == 'terminal' && win_gotoid(g:termwin)
    hide
    wincmd p
  else
    try
      if a:vsplit
        exec 'botright vertical sbuffer ' .. g:termbuf
      else
        exec 'botright sbuffer ' .. g:termbuf
      endif
      norm A
    catch
      if a:vsplit
        botright vertical terminal
      else
        botright terminal
      endif
      startinsert!
    endtry
    let g:termwin = win_getid()
  endif
endfunction

" switch between open terminal window and previous window
function term#Focus()
  if !exists('g:termbuf') || !exists('g:termwin') || win_findbuf(g:termbuf) == []
      echohl ErrorMsg | echo 'No terminal window' | echohl None
      return
  endif
  if win_getid() == g:termwin
    if tabpagewinnr(tabpagenr(), '$') == 1
      exec "normal! g\<tab>"
    else
      wincmd p
    endif
  else
    call win_gotoid(g:termwin)
    norm A
  endif
endfunction
